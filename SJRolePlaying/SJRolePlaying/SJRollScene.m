//
//  SJRollScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 12/17/13.
//  Copyright (c) 2013 tnantoka. All rights reserved.
//

#import "SJRollScene.h"

#import "SJComponents.h"

static const CGFloat DELAY = 5.0f;


@implementation SJRollScene {
    NSMutableArray *_labelNodes;
    SKLabelNode *_currentLabelNode;
}

- (void)createSceneContents {

    _labelNodes = @[].mutableCopy;
    
    for (NSDictionary *label in self.sceneData[@"roll"]) {
        SKLabelNode *labelNode = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
        labelNode.text = label[@"text"];
        labelNode.fontSize = [label[@"size"] floatValue];
        [_labelNodes addObject:labelNode];
    }
    
    [self performSelector:@selector(showNextLabelNode) withObject:nil afterDelay:DELAY];
    
}

- (void)showNextLabelNode {
    
    SKLabelNode *labelNode = _labelNodes.firstObject;
    labelNode.position = CGPointMake(CGRectGetMidX(self.frame), 0);
    [self addChild:labelNode];

    CGFloat y;
    CGFloat duration;
    if (_labelNodes.count > 1) {
        y = CGRectGetHeight(self.frame) + CGRectGetHeight(labelNode.frame);
        duration = [self.sceneData[@"speed"] floatValue];
    } else {
        y = CGRectGetMidY(self.frame) + CGRectGetMidY(labelNode.frame);
        duration = [self.sceneData[@"speed"] floatValue] / 2.0f;
    }

    SKAction *moveX = [SKAction moveByX:0 y:y duration:duration];
    SKAction *run = [SKAction runBlock:^{
        if (_labelNodes.count > 1) {
            [_currentLabelNode removeFromParent];
            [_labelNodes removeObjectAtIndex:0];
            [self showNextLabelNode];
        } else {
            self.nextScene = self.sceneData[@"next"];
            [self performSelector:@selector(loadNextScene) withObject:nil afterDelay:DELAY];
            return;
        }
    }];
    SKAction *sequence = [SKAction sequence:@[moveX, run]];
    [labelNode runAction:sequence];

    _currentLabelNode = labelNode;
}

@end
