//
//  SJUtilities.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/21.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJUtilities.h"

#import <BlocksKit/BlocksKit.h>

const CGFloat TILE_SIZE = 32.0f;

NSString * const kLangKey = @"lang";
NSString * const kSoundKey = @"sound";

NSString * const FONT_NORMAL = @"";

@implementation SJUtilities

+ (NSString *)lang {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kLangKey];
}

+ (void)setLang:(NSString *)lang {
    [[NSUserDefaults standardUserDefaults] setObject:lang forKey:kLangKey];
}

+ (BOOL)sound {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSoundKey];
}

+ (void)setSound:(BOOL)sound {
    [[NSUserDefaults standardUserDefaults] setBool:sound forKey:kSoundKey];
}

+ (void)openInSafari:(NSString *)urlString title:(NSString *)title {

    NSString *message = [NSString stringWithFormat:@"%@\n%@", title, urlString];
    
    UIAlertView *testView = [UIAlertView alertViewWithTitle:NSLocalizedString(@"Open in Safari?", nil) message:message];
    [testView addButtonWithTitle:NSLocalizedString(@"OK", nil) handler:^{
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [testView addButtonWithTitle:NSLocalizedString(@"Cancel", nil) handler:nil];
    [testView show];
}

@end
