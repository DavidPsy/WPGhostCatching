//
//  WPQuickComponents.h
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WPFontLarge   12.0f
#define WPFontNormal  18.0f
#define WPFontSmall   30.0f

#pragma mark - scene

void sceneForward(CCScene *toScene);
void sceneBack(CCScene *toScene);

#pragma mark - button

WPButton* makeButton(NSString *title, float fontSize,CGPoint pos,WPTapBlock blk);


#pragma mark - node

CCNode* makeLayer();

#pragma mark - code snap relative to my Xcode

/**
 blkDefine
 blkProperty
 blkMethod
 
 */


