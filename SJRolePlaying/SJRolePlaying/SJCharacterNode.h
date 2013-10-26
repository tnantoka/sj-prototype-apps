//
//  SJCharacterNode.h
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/21.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t {
    SJCharacterStateStop = 0,
    SJCharacterStateWalk,
} SJCharacterState;

typedef enum : uint8_t {
    SJCharacterDirectionDown = 0,
    SJCharacterDirectionUp,
    SJCharacterDirectionRight,
    SJCharacterDirectionLeft,
} SJCharacterDirection;

@interface SJCharacterNode : SKSpriteNode

- (id)initWithCharacterNamed:(NSString *)name;

- (void)stop;
- (void)walk;
- (void)moveTo:(CGPoint)location;

@end
