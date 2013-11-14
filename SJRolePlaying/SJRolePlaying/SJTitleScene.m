//
//  SJTitleScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/14.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJTitleScene.h"

#import "SJComponents.h"

static const CGFloat MARGIN = 10.0f;

@implementation SJTitleScene

- (void)createSceneContents {
    
    // Title
    SKLabelNode *titleLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Mosamosa"];
    titleLabel1.text = @"Prototype";
    titleLabel1.fontSize = 28.0f;
    titleLabel1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 80.0f);
    [self addChild:titleLabel1];

    SKLabelNode *titleLabel2 = [SKLabelNode labelNodeWithFontNamed:titleLabel1.fontName];
    titleLabel2.text = @"Quest";
    titleLabel2.position = CGPointMake(CGRectGetMidX(self.frame), titleLabel1.position.y - titleLabel1.frame.size.height - MARGIN);
    titleLabel2.fontSize = titleLabel1.fontSize;
    [self addChild:titleLabel2];

    // New game
    SJTapNode *newNode = [SJTapNode labelNodeWithFontNamed:@""];
    newNode.text = NSLocalizedString(@"New Game", nil);
    newNode.fontSize = 20.0f;
    newNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 0.0f);
    newNode.target = self;
    newNode.action = @selector(goNew);
    [self addChild:newNode];
    
    // Continue
    SJTapNode *continueNode = [SJTapNode labelNodeWithFontNamed:newNode.fontName];
    continueNode.text = NSLocalizedString(@"Continue", nil);
    continueNode.fontSize = newNode.fontSize;
    continueNode.position = CGPointMake(CGRectGetMidX(self.frame), newNode.position.y - newNode.frame.size.height - MARGIN);
    continueNode.target = self;
    continueNode.action = @selector(goContinue);
    continueNode.disabled = YES;
    [self addChild:continueNode];

    // Settings
    SJTapNode *settingsNode = [SJTapNode labelNodeWithFontNamed:newNode.fontName];
    settingsNode.text = NSLocalizedString(@"Settings", nil);
    settingsNode.fontSize = newNode.fontSize;
    settingsNode.position = CGPointMake(CGRectGetMidX(self.frame), continueNode.position.y - newNode.frame.size.height - MARGIN);
    settingsNode.target = self;
    settingsNode.action = @selector(goSettings);
    [self addChild:settingsNode];

    // Copyright
    SJTapNode *copyrightNode = [SJTapNode labelNodeWithFontNamed:newNode.fontName];
    copyrightNode.text = NSLocalizedString(@"© 2013 SpriteKit.jp", nil);
    copyrightNode.fontSize = 12.0f;
    copyrightNode.position = CGPointMake(CGRectGetMidX(self.frame), 40.0f);
    copyrightNode.target = self;
    copyrightNode.action = @selector(goCopyright);
    [self addChild:copyrightNode];

}

- (void)goNew {
    NSLog(@"New");
}

- (void)goContinue {
    NSLog(@"Continue");
}

- (void)goSettings {
    NSLog(@"Settings");
}

- (void)goCopyright {
    NSLog(@"Copyright");
}

@end
