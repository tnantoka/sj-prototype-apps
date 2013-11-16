//
//  SJTapNode.h
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/14.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SJTapNode : SKLabelNode

@property (nonatomic, assign) id target;
@property (nonatomic) SEL action;
@property (nonatomic) id object;

@property (nonatomic) BOOL disabled;

@end
