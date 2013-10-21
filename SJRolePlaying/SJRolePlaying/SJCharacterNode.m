//
//  SJCharacterNode.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/21.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJCharacterNode.h"

#import "SJComponents.h"

static const NSInteger STOP_ROW = 0;
static const NSInteger STOP_COLS = 2;

static const NSInteger WALK_ROW = 1;
static const NSInteger WALK_COLS = 4;

static const NSInteger UP_ROW = 3;
static const NSInteger RIGHT_ROW = 6;
static const NSInteger LEFT_ROW = 6;

static const CGFloat SPEED = 0.3f;

static NSString * const TILESHEET_NAME = @"clotharmor";
static NSString * const MOVE_KEY = @"move";

static const CGFloat TILE_SCALE = 0.5; // Map is 32x32 but character is 64x64.

@implementation SJCharacterNode {
    SJCharacterState _state;
    SJCharacterDirection _direction;
}

+ (id)characterNode {
    SJCharacterNode *character = [SJCharacterNode spriteNodeWithColor:nil size:CGSizeMake(TILE_SIZE / TILE_SCALE, TILE_SIZE / TILE_SCALE)];
    return character;
}

- (id)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size {
    if (self = [super initWithTexture:texture color:color size:size]) {
        [self createNodeContents];
    }
    return self;
}

- (void)createNodeContents {
    [self stop];
}

- (void)stop {
    if (_state & SJCharacterStateStop) return;
    [self animateWithRow:STOP_ROW cols:STOP_COLS time:0.6f];
    _state = SJCharacterStateStop;
}

- (void)walk {
    //if (_state & SJCharacterStateWalk) return;
    [self animateWithRow:WALK_ROW cols:WALK_COLS time:0.2f];
    _state = SJCharacterStateWalk;
}

- (void)animateWithRow:(NSInteger)row cols:(NSInteger)cols time:(CGFloat)time {
    
    NSArray *textures = [self texturesWithRow:row cols:cols];
    
    SKAction *animate = [SKAction animateWithTextures:textures timePerFrame:time];
    SKAction *forever = [SKAction repeatActionForever:animate];
    [self runAction:forever];
}

- (NSArray *)texturesWithRow:(int)row cols:(int)cols {
    
    SKTexture *tilesheetTexture = [SKTexture textureWithImageNamed:TILESHEET_NAME];
    
    self.xScale = 1.0f;
    switch (_direction) {
        case SJCharacterDirectionUp:
            row += UP_ROW;
            break;
        case SJCharacterDirectionDown:
            break;
        case SJCharacterDirectionRight:
            row += RIGHT_ROW;
            break;
        case SJCharacterDirectionLeft:
            row += LEFT_ROW;
            self.xScale = -1.0f;
            break;
    }
    
    NSMutableArray *textures = @[].mutableCopy;
    for (int col = 0; col < cols; col++) {
        CGFloat x = col * TILE_SIZE / TILE_SCALE / tilesheetTexture.size.width;
        CGFloat y = row * TILE_SIZE / TILE_SCALE / tilesheetTexture.size.height;
        CGFloat w = TILE_SIZE / TILE_SCALE / tilesheetTexture.size.width;
        CGFloat h = TILE_SIZE / TILE_SCALE / tilesheetTexture.size.height;
        
        CGRect rect = CGRectMake(x, y, w, h);
        
        SKTexture *texture = [SKTexture textureWithRect:rect inTexture:tilesheetTexture];
        [textures addObject:texture];
    }
    
    return textures;
}

- (void)moveTo:(CGPoint)location {
    
    NSMutableArray *actions = @[].mutableCopy;
    CGPoint diff = CGPointMake(floor((location.x - self.position.x) / TILE_SIZE), floor((location.y - self.position.y) / TILE_SIZE));
    
    CGFloat x = diff.x * TILE_SIZE;
    CGFloat y = diff.y * TILE_SIZE;
    
    SKAction *moveX = [SKAction moveByX:x y:0 duration:abs(diff.x) * SPEED];
    SKAction *moveY = [SKAction moveByX:0 y:y duration:abs(diff.y) * SPEED];
    
    SKAction *walk = [SKAction runBlock:^{
        [self walk];
    }];
    SKAction *stop = [SKAction runBlock:^{
        [self stop];
    }];
    
    SKAction *turnX = [SKAction runBlock:^{
        if (diff.x > 0) {
            _direction = SJCharacterDirectionRight;
        } else if (diff.x < 0){
            _direction = SJCharacterDirectionLeft;
        }
    }];
    SKAction *turnY = [SKAction runBlock:^{
        if (diff.y > 0) {
            _direction = SJCharacterDirectionUp;
        } else if (diff.y < 0){
            _direction = SJCharacterDirectionDown;
        }
    }];
    
    [actions addObject:turnX];
    [actions addObject:walk];
    [actions addObject:moveX];

    [actions addObject:turnY];
    [actions addObject:walk];
    [actions addObject:moveY];
    
    [actions addObject:stop];
    
    SKAction *sequence = [SKAction sequence:actions];
    
    [self runAction:sequence withKey:MOVE_KEY];
}


@end
