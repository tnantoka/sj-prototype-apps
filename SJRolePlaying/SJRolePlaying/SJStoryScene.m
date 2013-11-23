//
//  SJStoryScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/06.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJStoryScene.h"

#import "SJComponents.h"
#import <BlocksKit/BlocksKit.h>

typedef enum : uint8_t {
    SJStorySceneStateWalk = 0,
    SJStorySceneStateMessage,
} SJStorySceneState;

@interface SJStoryScene () <SKPhysicsContactDelegate>
@end

@implementation SJStoryScene {
    SJStorySceneState _state;
}

- (void)createSceneContents {
    _state = SJStorySceneStateWalk;
    self.physicsWorld.contactDelegate = self;
    
    SJMapNode *map = [[SJMapNode alloc] initWithMapNamed:self.sceneData[@"map"]];
    [self addChild:map];
    
    SJMessageNode *message = [[SJMessageNode alloc] initWithSize:CGSizeMake(self.size.width, self.size.height * 0.3f)];
    [self addChild:message];
    [self messageNode].hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint locaiton = [touch locationInNode:[self mapNode]];
    
    switch (_state) {
        case SJStorySceneStateWalk:
            [[self playerNode] moveTo:locaiton];
            break;
        case SJStorySceneStateMessage:
            if ([[self messageNode] hasNext]) {
                [[self messageNode] next];
            } else {
                [self messageNode].hidden = YES;
                _state = SJStorySceneStateWalk;
                [self loadNextScene];
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
            [self processEvent:name];
        }
    }
}

- (void)processEvent:(NSString *)name {
    
    NSDictionary *event = self.sceneData[@"events"][name];

    if (event) {
        [[self playerNode] removeAllActions];
    }

    if ([event[@"type"] isEqualToString:@"message"]) {
        _state = SJStorySceneStateMessage;
        [self messageNode].message = event[@"message"][[SJUtilities lang]];
        [self messageNode].hidden = NO;
        self.nextScene = event[@"next"];
        
    } else if ([event[@"type"] isEqualToString:@"confirm"]) {
        
        NSString *message = event[@"message"][[SJUtilities lang]];
        
        UIAlertView *alertView = [UIAlertView alertViewWithTitle:nil message:message];
        [alertView addButtonWithTitle:NSLocalizedString(@"Yes", nil) handler:^{
            [self processEvent:event[@"yes"]];
        }];
        [alertView addButtonWithTitle:NSLocalizedString(@"No", nil) handler:^{
            [self processEvent:event[@"no"]];
        }];
        [alertView show];
        
    }
    
}

@end
