//
//  SJMapNode.h
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/20.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

extern NSString * const kMapName;
extern NSString * const kPlayerName;

@interface SJMapNode : SKNode

- (id)initWithMapNamed:(NSString *)name;

@end
