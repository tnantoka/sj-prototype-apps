//
//  SJBaseScene.h
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/06.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SJBaseScene : SKScene

@property (nonatomic) BOOL contentCreated;
@property (nonatomic) NSDictionary *sceneData;
@property (nonatomic) NSString *nextScene;

- (id)initWithSize:(CGSize)size name:(NSString *)name;
- (void)createSceneContents;

- (void)loadScene:(NSString *)name;
- (void)loadNextScene;

@end
