//
//  WPPlayerScene.m
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPPlayerScene.h"
#import "WPHomeScene.h"

@implementation WPPlayerScene

- (id)init {
    self = [super init];
    if (self) {
        WPButton *backBtn = makeButton(@"back", WPFontNormal, ccp(0.2, 0.2), ^{
            sceneBack([[WPHomeScene alloc] init]);
        });
        [self addChild:backBtn];
    }
    return self;
}

- (void)onEnter {
    
}

@end
