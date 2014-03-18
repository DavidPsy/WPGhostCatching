//
//  WPButton.m
//  WPGhostCatching
//
//  Created by psy on 14-3-18.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPButton.h"

@implementation WPButton

- (id)init {
    self = [super init];
    if (self) {
        [self setTarget:self selector:@selector(onClicked)];
    }
    return self;
}

- (void)onClicked {
    if (_tapBlock) {
        _tapBlock();
    }
}

@end
