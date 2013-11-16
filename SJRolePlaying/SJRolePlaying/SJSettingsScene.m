//
//  SJSettingsScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/15.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJSettingsScene.h"

#import "SJComponents.h"

static const CGFloat PADDING = 20.0f;
static const CGFloat MARGIN = 15.0f;
static NSString * const LANG_NAME = @"lang";
static NSString * const SOUND_NAME = @"sound";
static NSString * const SCROLL_NAME = @"scroll";

@implementation SJSettingsScene

- (void)createSceneContents {
    
    // Scroll
    SKSpriteNode *scrollNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(self.frame.size.width, 500.0f)];
    scrollNode.name = SCROLL_NAME;
    scrollNode.anchorPoint = CGPointMake(0, 0);
    scrollNode.position = CGPointMake(0, self.frame.size.height - scrollNode.size.height);
    
    [self addChild:scrollNode];
    
    // Back
    SJTapNode *backNode = [SJTapNode labelNodeWithFontNamed:FONT_NORMAL];
    backNode.text = NSLocalizedString(@"< Back", nil);
    backNode.fontSize = 18.0f;
    backNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    backNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    backNode.position = CGPointMake(PADDING, scrollNode.size.height - PADDING);
    backNode.target = self;
    backNode.action = @selector(goBack);
    [scrollNode addChild:backNode];
    
    // Line 0
    SKShapeNode *lineNode = [self newLineNode];
    lineNode.position = CGPointMake(PADDING, backNode.position.y - backNode.frame.size.height - MARGIN);
    [scrollNode addChild:lineNode];

    // Lang
    SKLabelNode *langLabel = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
    langLabel.text = NSLocalizedString(@"Language", nil);
    langLabel.fontSize = 18.0f;
    langLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    langLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    langLabel.position = CGPointMake(PADDING, lineNode.position.y - lineNode.frame.size.height - MARGIN);
    [scrollNode addChild:langLabel];
    
    SJTapNode *langNode = [SJTapNode labelNodeWithFontNamed:FONT_NORMAL];
    langNode.text = NSLocalizedString([SJUtilities lang], nil);
    langNode.fontSize = langLabel.fontSize * 0.8f;
    langNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    langNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    langNode.position = CGPointMake(CGRectGetMaxX(self.frame) - PADDING, langLabel.position.y);
    langNode.target = self;
    langNode.action = @selector(toggleLang);
    langNode.name = LANG_NAME;
    [scrollNode addChild:langNode];
    
    // Line 1
    SKShapeNode *lineNode1 = [self newLineNode];
    lineNode1.position = CGPointMake(PADDING, langLabel.position.y - langLabel.frame.size.height - MARGIN);
    [scrollNode addChild:lineNode1];

    // Sound
    SKLabelNode *soundLabel = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
    soundLabel.text = NSLocalizedString(@"Sound", nil);
    soundLabel.fontSize = langLabel.fontSize;
    soundLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    soundLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    soundLabel.position = CGPointMake(PADDING, lineNode1.position.y - lineNode1.frame.size.height - MARGIN);
    [scrollNode addChild:soundLabel];

    SJTapNode *soundNode = [SJTapNode labelNodeWithFontNamed:FONT_NORMAL];
    soundNode.text = [self soundText];
    soundNode.fontSize = langNode.fontSize;
    soundNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    soundNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    soundNode.position = CGPointMake(CGRectGetMaxX(self.frame) - PADDING, soundLabel.position.y);
    soundNode.target = self;
    soundNode.action = @selector(toggleSound);
    soundNode.name = SOUND_NAME;
    [scrollNode addChild:soundNode];

    // Line 2
    SKShapeNode *lineNode2 = [self newLineNode];
    lineNode2.position = CGPointMake(PADDING, soundLabel.position.y - soundLabel.frame.size.height - MARGIN);
    [scrollNode addChild:lineNode2];

    // Thanks
    SKLabelNode *thanksLabel = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
    thanksLabel.text = NSLocalizedString(@"Thanks", nil);
    thanksLabel.fontSize = langLabel.fontSize;
    thanksLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    thanksLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    thanksLabel.position = CGPointMake(PADDING, lineNode2.position.y - lineNode2.frame.size.height - MARGIN);
    [scrollNode addChild:thanksLabel];

    CGFloat thanksY = thanksLabel.position.y - thanksLabel.frame.size.height - MARGIN;
    NSArray *sites = @[
                        @{
                            @"title" : @"BrowserQuest",
                            @"url" : @"https://github.com/browserquest/BrowserQuest",
                            },
                        @{
                            @"title" : @"BlocksKit",
                            @"url" : @"https://github.com/pandamonia/BlocksKit",
                            },
                        @{
                            @"title" : @"PhysicsDebugger",
                            @"url" : @"https://github.com/ymc-thzi/PhysicsDebugger",
                            },
                        @{
                            @"title" : @"@Longsword",
                            @"url" : @"http://lovalotta.pya.jp/mosamosa/",
                            },
                        ];
    for (NSDictionary *site in sites) {
        SJTapNode *thanksNode = [SJTapNode labelNodeWithFontNamed:FONT_NORMAL];
        thanksNode.text = site[@"title"];
        thanksNode.fontSize = langNode.fontSize;
        thanksNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        thanksNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        thanksNode.position = CGPointMake(PADDING, thanksY);
        thanksNode.target = self;
        thanksNode.action = @selector(openInSafari:);
        thanksNode.object = site;
        [scrollNode addChild:thanksNode];
        thanksY -= (thanksNode.frame.size.height + MARGIN);
    }

    // Line 3
    SKShapeNode *lineNode3 = [self newLineNode];
    lineNode3.position = CGPointMake(PADDING, thanksY);
    [scrollNode addChild:lineNode3];

    // License
    SKLabelNode *licenseLabel = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
    licenseLabel.text = NSLocalizedString(@"License", nil);
    licenseLabel.fontSize = langLabel.fontSize;
    licenseLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    licenseLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    licenseLabel.position = CGPointMake(PADDING, lineNode3.position.y - lineNode3.frame.size.height - MARGIN);
    [scrollNode addChild:licenseLabel];

    SJTapNode *licenseNode = [SJTapNode labelNodeWithFontNamed:FONT_NORMAL];
    licenseNode.text = NSLocalizedString(@"CC-BY-SA 3.0", nil);
    licenseNode.fontSize = langNode.fontSize;
    licenseNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    licenseNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    licenseNode.position = CGPointMake(PADDING, licenseLabel.position.y - licenseLabel.frame.size.height - MARGIN);
    licenseNode.target = self;
    licenseNode.action = @selector(openInSafari:);
    licenseNode.object = @{
                          @"title" : @"Creative Commons — Attribution-ShareAlike 3.0 Unported — CC BY-SA 3.0",
                          @"url" : @"http://creativecommons.org/licenses/by-sa/3.0/",
                          };
    [scrollNode addChild:licenseNode];

    // Line 4
    SKShapeNode *lineNode4 = [self newLineNode];
    lineNode4.position = CGPointMake(PADDING, licenseNode.position.y - licenseNode.frame.size.height - MARGIN);
    [scrollNode addChild:lineNode4];

    // Copyright
    SKLabelNode *copyrightLabel = [SKLabelNode labelNodeWithFontNamed:FONT_NORMAL];
    copyrightLabel.text = NSLocalizedString(@"Copyright", nil);
    copyrightLabel.fontSize = langLabel.fontSize;
    copyrightLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    copyrightLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    copyrightLabel.position = CGPointMake(PADDING, lineNode4.position.y - lineNode4.frame.size.height - MARGIN);
    [scrollNode addChild:copyrightLabel];
    
    SJTapNode *copyrightNode = [SJTapNode labelNodeWithFontNamed:FONT_NORMAL];
    copyrightNode.text = NSLocalizedString(@"© 2013 SpriteKit.jp", nil);
    copyrightNode.fontSize = langNode.fontSize;
    copyrightNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    copyrightNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    copyrightNode.position = CGPointMake(PADDING, copyrightLabel.position.y - copyrightLabel.frame.size.height - MARGIN);
    copyrightNode.target = self;
    copyrightNode.action = @selector(openInSafari:);
    copyrightNode.object = @{
                           @"title" : @"SpriteKit.jp",
                           @"url" : @"http://spritekit.jp/",
                           };
    [scrollNode addChild:copyrightNode];

    // Line 5
    SKShapeNode *lineNode5 = [self newLineNode];
    lineNode5.position = CGPointMake(PADDING, copyrightNode.position.y - copyrightNode.frame.size.height - MARGIN);
    [scrollNode addChild:lineNode5];

}

- (SKShapeNode *)newLineNode {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, self.frame.size.width - PADDING * 2.0f, 0);
    
    SKShapeNode *lineNode = [SKShapeNode node];
    lineNode.path = path;
    lineNode.strokeColor = [SKColor whiteColor];
    lineNode.lineWidth = 0.5f;
    lineNode.antialiased = NO;
    CGPathRelease(path);
    
    return lineNode;
}

- (void)toggleLang {
    if ([[SJUtilities lang] isEqualToString:@"ja"]) {
        [SJUtilities setLang:@"en"];
    } else {
        [SJUtilities setLang:@"ja"];
    }
    [self langNode].text = [SJUtilities lang];
}

- (void)toggleSound {
    if ([SJUtilities sound]) {
        [SJUtilities setSound:NO];
    } else {
        [SJUtilities setSound:YES];
    }
    [self soundNode].text = [self soundText];
}

- (void)openInSafari:(NSDictionary *)site {
    [SJUtilities openInSafari:site[@"url"] title:site[@"title"]];
}

- (void)goBack {
    [self loadScene:@"title"];
}

- (NSString *)soundText {
    return NSLocalizedString([SJUtilities sound] ? @"ON" : @"OFF", nil);
}

- (SJTapNode *)langNode {
    return (SJTapNode *)[[self scrollNode] childNodeWithName:LANG_NAME];
}

- (SKSpriteNode *)scrollNode {
    return (SKSpriteNode *)[self childNodeWithName:SCROLL_NAME];
}

- (SJTapNode *)soundNode {
    return (SJTapNode *)[[self scrollNode] childNodeWithName:SOUND_NAME];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    
    CGFloat translationY = positionInScene.y - previousPosition.y;
    
    SKSpriteNode *scrollNode = [self scrollNode];
    CGPoint position = CGPointMake(scrollNode.position.x, scrollNode.position.y + translationY);
    
    CGFloat top = -(scrollNode.size.height - self.frame.size.height);
    CGFloat bottom = 0;
    if (position.y < top) {
        position.y = top;
    } else if (position.y > bottom) {
        position.y = bottom;
    }

    scrollNode.position = position;
}

@end
