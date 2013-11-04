//
//  SJShopScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/16.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJShopScene.h"

#import "SJComponents.h"

typedef enum : uint8_t {
    SJShopSceneStateWalk = 0,
    SJShopSceneStateMessage,
} SJShopSceneState;

@interface SJShopScene () <SKPhysicsContactDelegate>
@end

@implementation SJShopScene {
    BOOL _contentCreated;
    SJShopSceneState _state;
}

- (void)didMoveToView:(SKView *)view {
    if (!_contentCreated) {
        [self createSceneContents];
        _contentCreated = YES;
    }
}

- (void)createSceneContents {
    _state = SJShopSceneStateWalk;
    self.physicsWorld.contactDelegate = self;

    SJMapNode *map = [[SJMapNode alloc] initWithMapNamed:@"shop"];
    [self addChild:map];
    
    SJMessageNode *message = [[SJMessageNode alloc] initWithSize:CGSizeMake(self.size.width, self.size.height * 0.3f)];
    [self addChild:message];
    [self messageNode].hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint locaiton = [touch locationInNode:[self mapNode]];
    
    switch (_state) {
        case SJShopSceneStateWalk:
            [[self playerNode] moveTo:locaiton];
            break;
        case SJShopSceneStateMessage:
            if ([[self messageNode] hasNext]) {
                [[self messageNode] next];
            } else {
                [self messageNode].hidden = YES;
                _state = SJShopSceneStateWalk;
            }
            break;
    }
}

- (SKNode *)mapNode {
    return [self childNodeWithName:kMapName];
}

- (SJMessageNode *)messageNode {
    return (SJMessageNode *)[self childNodeWithName:kMessageName];
}

- (SJCharacterNode *)playerNode {
    return (SJCharacterNode *)[[self mapNode] childNodeWithName:kPlayerName];
}

- (NSDictionary *)event {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"event" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *event = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    return event;
}

- (void)didEvaluateActions {
    // Update zPosition with y-coordinate;
    for (SKNode *node in [[self mapNode] children]) {
        if ([node isKindOfClass:[SJCharacterNode class]]) {
            node.zPosition = self.size.height - node.position.y;
        }
    }
}

# pragma mark - SKPhysicsContactDelegate

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & playerCategory) != 0) {
        if ((secondBody.categoryBitMask & characterCategory) != 0) {
            SJCharacterNode *node = (SJCharacterNode *)secondBody.node;
            NSString *name = node.name;
            NSDictionary *e = [self event][name];
            if ([e[@"type"] isEqualToString:@"message"]) {
                _state = SJShopSceneStateMessage;
                [self messageNode].message = e[@"message"][[SJUtilities lang]];
                [self messageNode].hidden = NO;
            }
        }
    }
}


@end
