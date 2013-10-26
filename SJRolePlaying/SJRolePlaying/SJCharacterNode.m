//
//  SJCharacterNode.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/21.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJCharacterNode.h"

#import "SJComponents.h"

static NSString * const CHARACTERS_NAME = @"characters";
static NSString * const FILE_TYPE = @"json";

static NSString * const MOVE_KEY = @"move";

@implementation SJCharacterNode {
    SJCharacterState _state;
    SJCharacterDirection _direction;
    NSDictionary *_character;
}

- (id)initWithCharacterNamed:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:CHARACTERS_NAME ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *characters = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    NSMutableDictionary *character = [characters[@"default"] mutableCopy];

    [character addEntriesFromDictionary:characters[name]];

    CGFloat size = [character[@"size"] floatValue];
    
    if (self = [super initWithColor:nil size:CGSizeMake(size, size)]) {
        _character = character;
        [self createNodeContents];
    }
    return self;
}

- (void)createNodeContents {
    [self stop];
}

- (void)stop {
    if (_state & SJCharacterStateStop) return;
    
    NSInteger row = [_character[@"stop_row"] integerValue];
    NSInteger cols = [_character[@"stop_cols"] integerValue];
    CGFloat time = [_character[@"stop_time"] floatValue];
    
    [self animateWithRow:row cols:cols time:time];
    _state = SJCharacterStateStop;
}

- (void)walk {
    //if (_state & SJCharacterStateWalk) return;

    NSInteger row = [_character[@"walk_row"] integerValue];
    NSInteger cols = [_character[@"walk_cols"] integerValue];
    CGFloat time = [_character[@"walk_time"] floatValue];

    [self animateWithRow:row cols:cols time:time];
    _state = SJCharacterStateWalk;
}

- (void)animateWithRow:(NSInteger)row cols:(NSInteger)cols time:(CGFloat)time {
    
    NSArray *textures = [self texturesWithRow:row cols:cols];
    
    SKAction *animate = [SKAction animateWithTextures:textures timePerFrame:time];
    SKAction *forever = [SKAction repeatActionForever:animate];
    [self runAction:forever];
}

- (NSArray *)texturesWithRow:(int)row cols:(int)cols {
    
    SKTexture *tilesheetTexture = [SKTexture textureWithImageNamed:_character[@"name"]];
    
    NSInteger upRow = [_character[@"up_row"] integerValue];
    NSInteger rigthRow = [_character[@"right_row"] integerValue];
    NSInteger leftRow = [_character[@"left_row"] integerValue];

    self.xScale = 1.0f;
    switch (_direction) {
        case SJCharacterDirectionUp:
            row += upRow;
            break;
        case SJCharacterDirectionDown:
            break;
        case SJCharacterDirectionRight:
            row += rigthRow;
            break;
        case SJCharacterDirectionLeft:
            row += leftRow;
            self.xScale = -1.0f;
            break;
    }
    
    CGFloat scale = TILE_SIZE / [_character[@"size"] floatValue];

    NSMutableArray *textures = @[].mutableCopy;
    for (int col = 0; col < cols; col++) {
        CGFloat x = col * TILE_SIZE / scale / tilesheetTexture.size.width;
        CGFloat y = row * TILE_SIZE / scale / tilesheetTexture.size.height;
        CGFloat w = TILE_SIZE / scale / tilesheetTexture.size.width;
        CGFloat h = TILE_SIZE / scale / tilesheetTexture.size.height;
        
        CGRect rect = CGRectMake(x, y, w, h);
        
        SKTexture *texture = [SKTexture textureWithRect:rect inTexture:tilesheetTexture];
        [textures addObject:texture];
    }
    
    return textures;
}

- (void)moveTo:(CGPoint)location {
    
    NSMutableArray *actions = @[].mutableCopy;
    
    CGFloat diffX = round((location.x - self.position.x) / TILE_SIZE);
    CGFloat diffY = round((location.y - self.position.y) / TILE_SIZE);
    
    CGFloat x = diffX * TILE_SIZE;
    CGFloat y = diffY * TILE_SIZE;
        
    CGFloat speed = [_character[@"speed"] floatValue];

    SKAction *moveX = [SKAction moveByX:x y:0 duration:abs(diffX) * speed];
    SKAction *moveY = [SKAction moveByX:0 y:y duration:abs(diffY) * speed];
    
    SKAction *walk = [SKAction runBlock:^{
        [self walk];
    }];
    SKAction *stop = [SKAction runBlock:^{
        [self stop];
    }];
    
    SKAction *turnX = [SKAction runBlock:^{
        if (diffX > 0) {
            _direction = SJCharacterDirectionRight;
        } else if (diffX < 0){
            _direction = SJCharacterDirectionLeft;
        }
    }];
    SKAction *turnY = [SKAction runBlock:^{
        if (diffY > 0) {
            _direction = SJCharacterDirectionUp;
        } else if (diffY < 0){
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
