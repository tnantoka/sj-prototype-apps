//
//  SJTapNode.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/14.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJTapNode.h"

static const CGFloat BLEND_SELECTED = 0.5f;
static const CGFloat BLEND_NORMAL = 0;
static const CGFloat BLEND_DISABLED = 0.9;

@implementation SJTapNode

- (id)initWithFontNamed:(NSString *)fontName {
    if (self = [super initWithFontNamed:fontName]) {
        self.color = [SKColor grayColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_disabled) return;
    
    self.colorBlendFactor = BLEND_SELECTED;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_disabled) return;

    self.colorBlendFactor = BLEND_NORMAL;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_disabled) return;
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self.scene];
    SKNode *node = [self.scene nodeAtPoint:positionInScene];
    
    if ([node isEqual:self]) {
        if (_target && [_target respondsToSelector:_action]) {
            // PerformSelector may cause a leak because its selector is unknown
            //[_target performSelector:_action withObject:_object];
            [_target performSelector:_action withObject:_object afterDelay:0];
        }
    }

    [self touchesCancelled:touches withEvent:event];
}

- (void)setDisabled:(BOOL)disabled {
    _disabled = disabled;
    self.colorBlendFactor = _disabled ? BLEND_DISABLED : BLEND_NORMAL;
}

@end
