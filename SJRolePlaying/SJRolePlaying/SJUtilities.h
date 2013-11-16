//
//  SJUtilities.h
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/21.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CGFloat TILE_SIZE;

extern NSString * const kLangKey;
extern NSString * const kSoundKey;

extern NSString * const FONT_NORMAL;

@interface SJUtilities : NSObject

+ (NSString *)lang;
+ (void)setLang:(NSString *)lang;

+ (BOOL)sound;
+ (void)setSound:(BOOL)sound;

+ (void)openInSafari:(NSString *)urlString title:(NSString *)title;

@end
