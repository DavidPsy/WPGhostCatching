//
//  WPBaseScene.m
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPBaseScene.h"

@implementation WPBaseScene

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    return self;
}

@end
