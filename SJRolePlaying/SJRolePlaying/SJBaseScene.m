//
//  SJBaseScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/06.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJBaseScene.h"

#import "SJStoryScene.h"

@implementation SJBaseScene

- (id)initWithSize:(CGSize)size name:(NSString *)name {
    if (self = [super initWithSize:size]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        self.sceneData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    if (!_contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents {
    
}

- (void)loadScene:(NSString *)name {
    SKScene *scene;
    if ([name hasPrefix:@"story"]) {
        scene = [[SJStoryScene alloc] initWithSize:self.size name:name];
    }
    SKTransition *transition = [SKTransition fadeWithDuration:0.6f];
    [self.view presentScene:scene transition:transition];
}

- (void)loadNextScene {
    if (self.nextScene) {
        [self loadScene:self.nextScene];
    }
}

@end
