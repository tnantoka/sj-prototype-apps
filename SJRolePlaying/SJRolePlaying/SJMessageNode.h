//
//  SJMessageNode.h
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/31.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

extern NSString * const kMessageName;

@interface SJMessageNode : SKNode

@property (nonatomic) NSString *message;

- (id)initWithSize:(CGSize)size;

- (void)next;
- (BOOL)hasNext;

@end
