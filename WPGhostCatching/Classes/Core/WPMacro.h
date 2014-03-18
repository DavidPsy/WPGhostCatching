//
//  WPMacro.h
//  WPGhostCatching
//
//  Created by psy on 14-3-18.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#ifndef WPGhostCatching_WPMacro_h
#define WPGhostCatching_WPMacro_h

#import "MTAlertView.h"
#import "DSActivityView.h"
#import "cocos2d.h"

#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]

#define Toast(s) [DSActivityView activityViewForView:[CCDirector sharedDirector].view withLabel:s];

#endif
