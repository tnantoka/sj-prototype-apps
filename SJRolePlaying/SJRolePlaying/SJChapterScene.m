//
//  SJChapterScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/24.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJChapterScene.h"

#import "SJComponents.h"

static const CGFloat MARGIN = 10.0f;
static const CGFloat DELAY = 3.0f;

@implementation SJChapterScene

- (void)createSceneContents {
    
    SKLabelNode *titleLabel1 = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
    titleLabel1.text = self.sceneData[@"title"][[SJUtilities lang]];
    titleLabel1.fontSize = 28.0f;
    titleLabel1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + MARGIN);
    titleLabel1.verticalAlignmentMode =SKLabelVerticalAlignmentModeBottom;
    [self addChild:titleLabel1];
    
    SKLabelNode *titleLabel2 = [SKLabelNode labelNodeWithFontNamed:titleLabel1.fontName];
    titleLabel2.text = self.sceneData[@"subtitle"][[SJUtilities lang]];;
    titleLabel2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - MARGIN);
    titleLabel2.fontSize = 20.0f;
    titleLabel2.verticalAlignmentMode =SKLabelVerticalAlignmentModeTop;
    [self addChild:titleLabel2];
    
    self.nextScene = self.sceneData[@"next"];
    [self performSelector:@selector(loadNextScene) withObject:nil afterDelay:DELAY];
}

@end
