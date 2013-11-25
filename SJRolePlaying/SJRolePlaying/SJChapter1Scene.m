//
//  SJChapter1Scene.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/11/24.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJChapter1Scene.h"

@implementation SJChapter1Scene

- (void)createSceneContents {
    [self performSelector:@selector(loadScene:) withObject:@"chapter_1" afterDelay:0.3f];
    //[self loadScene:@"chapter_1"];
}

@end
