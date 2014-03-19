//
//  WPButton.m
//  WPGhostCatching
//
//  Created by psy on 14-3-18.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPButton.h"

@implementation WPButton {
    BOOL _enableTap;
}

- (void)onClicked {
    if (_tapBlock) {
        _tapBlock();
    }
}

- (void)setTapBlock:(WPTapBlock)tapBlock {
    _tapBlock = [tapBlock copy];
    
    if (!_enableTap) {
        _enableTap = YES;
        [self setTarget:self selector:@selector(onClicked)];
    }
}

@end
