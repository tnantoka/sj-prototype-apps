//
//  SJShopScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/16.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJShopScene.h"

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
    [self loadScene:@"story_opening"];
}

@end
