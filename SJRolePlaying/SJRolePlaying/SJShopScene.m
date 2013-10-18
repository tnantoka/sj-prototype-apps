//
//  SJShopScene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/16.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJShopScene.h"

static const CGFloat TILE_SIZE = 32.0f;
static const CGFloat MAP_COLS = 20.0f;

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
    
    NSLog(@"frame: %@", NSStringFromCGRect(self.frame));

    NSString *shop = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop" ofType:@"csv"]  encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"shop: %@", shop);
    
    SKTexture *tilesheet = [SKTexture textureWithImageNamed:@"tilesheet"];
    
    NSArray *layers = [shop componentsSeparatedByString:@"\n\n"];
    
    for (NSString *layer in layers) {

        NSArray *rows = [[[layer componentsSeparatedByString:@"\n"] reverseObjectEnumerator] allObjects];
        for (int i = 0; i < rows.count; i++) {
            NSString *row = rows[i];
            NSArray *cols = [row componentsSeparatedByString:@","];
            for (int j = 0; j < cols.count; j++) {
                
                NSInteger col = [cols[j] integerValue];
                
                if (col > -1) {
                    CGFloat x = col % (NSInteger)MAP_COLS * TILE_SIZE / tilesheet.size.width;
                    CGFloat y = col / (NSInteger)MAP_COLS * TILE_SIZE / tilesheet.size.height;
                    CGFloat w = TILE_SIZE / tilesheet.size.width;
                    CGFloat h = TILE_SIZE / tilesheet.size.height;
                    
                    CGRect rect = CGRectMake(x, y, w, h);
                    SKTexture *tile = [SKTexture textureWithRect:rect inTexture:tilesheet];

                    SKSpriteNode *tileSprite = [SKSpriteNode spriteNodeWithTexture:tile];

                    CGPoint position = CGPointMake(j * TILE_SIZE, i * TILE_SIZE);
                    tileSprite.anchorPoint = CGPointMake(0, 0);
                    tileSprite.position = position;

                    [self addChild:tileSprite];
                    
                    NSLog(@"col: %d, rect: %@, position: %@", col, NSStringFromCGRect(rect), NSStringFromCGPoint(position));
                }
            }
        }

    }
    

}

@end
