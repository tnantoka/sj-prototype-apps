//
//  SJBaseScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/06.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJBaseScene.h"

#import "SJStoryScene.h"
#import "SJSettingsScene.h"
#import "SJTitleScene.h"
#import "SJChapterScene.h"

static const CGFloat SCENE_DURATION = 0.6f;

@implementation SJBaseScene

- (id)initWithSize:(CGSize)size name:(NSString *)name {
    if (self = [super initWithSize:size]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSError *error = nil;
            self.sceneData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
            }
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
    } else if ([name hasPrefix:@"settings"]) {
        scene = [[SJSettingsScene alloc] initWithSize:self.size name:name];
    } else if ([name hasPrefix:@"title"]) {
        scene = [[SJTitleScene alloc] initWithSize:self.size name:name];
    } else if ([name hasPrefix:@"chapter"]) {
        scene = [[SJChapterScene alloc] initWithSize:self.size name:name];
    }
    if (scene) {
        SKTransition *transition = [SKTransition fadeWithDuration:SCENE_DURATION];
        [self.view presentScene:scene transition:transition];        
    }
}

- (void)loadNextScene {
    if (self.nextScene) {
        [self loadScene:self.nextScene];
    }
}

@end
