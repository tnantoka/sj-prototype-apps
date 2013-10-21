//
//  SJShopScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/16.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJShopScene.h"

#import "SJComponents.h"

@implementation SJShopScene {
    BOOL _contentCreated;
}

- (void)didMoveToView:(SKView *)view {
    if (!_contentCreated) {
        [self createSceneContents];
        _contentCreated = YES;
    }
}

- (void)createSceneContents {
    SJMapNode *map = [[SJMapNode alloc] initWithMapNamed:@"shop"];
    [self addChild:map];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint locaiton = [touch locationInNode:[self mapNode]];
    
    SJCharacterNode *playerNode = [self playerNode];
    [playerNode moveTo:locaiton];
}

- (SKNode *)mapNode {
    return [self childNodeWithName:kMapName];
}

- (SJCharacterNode *)playerNode {
    return (SJCharacterNode *)[[self mapNode] childNodeWithName:kPlayerName];
}

@end
