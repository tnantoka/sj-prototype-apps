//
//  SJUtilities.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/21.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJUtilities.h"

const CGFloat TILE_SIZE = 32.0f;

NSString * const kLangKey = @"lang";

@implementation SJUtilities

+ (NSString *)lang {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kLangKey];
}

@end
