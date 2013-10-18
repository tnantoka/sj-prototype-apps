//
//  SJTilesheetScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/17.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJTilesheetScene.h"

static const CGFloat TILE_SIZE = 32.0f;
static const CGFloat SCALE = 0.75f;

static NSString * const BG_NAME = @"bg";

@implementation SJTilesheetScene {
    BOOL _contentCreated;
}

- (void)didMoveToView:(SKView *)view {
    if (!_contentCreated) {
        [self createSceneContents];
        _contentCreated = YES;
    }
}

/*
- (void)createSceneContents {

    self.backgroundColor = [SKColor darkGrayColor];

    SKTexture *tilesheet = [SKTexture textureWithImageNamed:@"tilesheet"];
    
    NSLog(@"tileSize: %@", NSStringFromCGSize(tilesheet.size));

    SKSpriteNode *bgSprite = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:tilesheet.size];
    bgSprite.name = BG_NAME;
    [self addChild:bgSprite];
    
    NSInteger cols = tilesheet.size.width / TILE_SIZE;
    NSInteger rows = tilesheet.size.height / TILE_SIZE;
    
    NSLog(@"cols: %d, rows: %d", cols, rows);
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            CGFloat x = i * TILE_SIZE / tilesheet.size.width;
            CGFloat y = j * TILE_SIZE / tilesheet.size.height;
            CGFloat w = TILE_SIZE / tilesheet.size.width;
            CGFloat h = TILE_SIZE / tilesheet.size.height;
            
            CGRect rect = CGRectMake(x, y, w, h);
            
            SKTexture *tile = [SKTexture textureWithRect:rect inTexture:tilesheet];
            SKSpriteNode *tileNode = [SKSpriteNode spriteNodeWithTexture:tile];
            tileNode.anchorPoint = CGPointMake(0, 0);
            CGPoint position = CGPointMake(i * TILE_SIZE * SCALE, j * TILE_SIZE * SCALE);
            tileNode.xScale = tileNode.yScale = SCALE;
            tileNode.position = position;
            [bgSprite addChild:tileNode];
            
            NSLog(@"rect: %@, position: %@", NSStringFromCGRect(rect), NSStringFromCGPoint(position));
            
            //SKLabelNode *pointLabel = [SKLabelNode labelNodeWithFontNamed:@"Mosamosa"];
            SKLabelNode *pointLabel = [SKLabelNode labelNodeWithFontNamed:@""];
            pointLabel.text = [NSString stringWithFormat:@"%d", i + j * cols];
            pointLabel.position = CGPointMake(position.x + TILE_SIZE * SCALE / 2.0f, position.y + TILE_SIZE * SCALE / 2.0f);
            pointLabel.fontSize = 14.0f * SCALE;
            //pointLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            pointLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
            //pointLabel.color = [SKColor blueColor];
            //pointLabel.colorBlendFactor = 1.0f;
            [bgSprite addChild:pointLabel];
            
            SKShapeNode *borderShape = SKShapeNode.new;
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, CGRectMake(0, 0, TILE_SIZE * SCALE, TILE_SIZE * SCALE));
            borderShape.path = path;
            borderShape.lineWidth = 0.9f;
            borderShape.strokeColor = [SKColor whiteColor];
            borderShape.position = position;
            borderShape.glowWidth = 0;
            [bgSprite addChild:borderShape];

        }
    }
    
}
*/

- (void)createSceneContents {
    self.backgroundColor = [SKColor darkGrayColor];
    
    SKTexture *tilesheet = [SKTexture textureWithImageNamed:@"tilesheet"];
    
    SKSpriteNode *bgSprite = [SKSpriteNode spriteNodeWithTexture:tilesheet];
    bgSprite.xScale = bgSprite.yScale = SCALE;
    bgSprite.anchorPoint = CGPointMake(0, 0);
    bgSprite.name = BG_NAME;
    [self addChild:bgSprite];
    
    NSInteger cols = tilesheet.size.width / TILE_SIZE;
    NSInteger rows = tilesheet.size.height / TILE_SIZE;
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            CGPoint position = CGPointMake(i * TILE_SIZE, j * TILE_SIZE);
            
            SKLabelNode *pointLabel = [SKLabelNode labelNodeWithFontNamed:@""];
            pointLabel.text = [NSString stringWithFormat:@"%d", i + j * cols];
            pointLabel.position = CGPointMake(position.x + TILE_SIZE / 2.0f, position.y + TILE_SIZE / 2.0f);
            pointLabel.fontSize = 14.0f;
            pointLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
            [bgSprite addChild:pointLabel];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // http://www.raywenderlich.com/44270/sprite-kit-tutorial-how-to-drag-and-drop-sprites
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
    SKSpriteNode *bgSprite = (SKSpriteNode *)[self childNodeWithName:BG_NAME];
    CGPoint position = CGPointMake(bgSprite.position.x + translation.x, bgSprite.position.y + translation.y);
    
    //if (position.x < -bgSprite.size.width * SCALE + self.frame.size.width) {
    //    position.x = -bgSprite.size.width * SCALE + self.frame.size.width;
    if (position.x < -bgSprite.size.width + self.frame.size.width) {
        position.x = -bgSprite.size.width + self.frame.size.width;
    } else if (position.x > 0) {
        position.x = 0;
    }
    //if (position.y < -bgSprite.size.height * SCALE + self.frame.size.height) {
    //    position.y = -bgSprite.size.height * SCALE + self.frame.size.height;
    if (position.y < -bgSprite.size.height + self.frame.size.height) {
        position.y = -bgSprite.size.height + self.frame.size.height;
    } else if (position.y > 0) {
        position.y = 0;
    }
    NSLog(@"position: %@", NSStringFromCGPoint(position));
    bgSprite.position = position;
}


@end
