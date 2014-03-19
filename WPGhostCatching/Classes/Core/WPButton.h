//
//  WPButton.h
//  WPGhostCatching
//
//  Created by psy on 14-3-18.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "CCButton.h"

typedef void(^WPTapBlock)();

@interface WPButton : CCButton

@property (nonatomic, copy) WPTapBlock tapBlock;

@end
