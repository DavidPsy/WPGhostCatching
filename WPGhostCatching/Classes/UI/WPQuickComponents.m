//
//  WPQuickComponents.m
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPQuickComponents.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

#pragma mark -
void sceneForward(CCScene *toScene) {
    [[CCDirector sharedDirector] replaceScene:toScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

void sceneBack(CCScene *toScene) {
    [[CCDirector sharedDirector] replaceScene:toScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

#pragma mark - 

WPButton* makeButton(NSString *title, float fontSize,CGPoint pos,WPTapBlock blk) {
    WPButton *btn = [WPButton buttonWithTitle:title fontName:@"Verdana-Bold" fontSize:fontSize];
    btn.positionType = CCPositionTypeNormalized;
    btn.position = pos;
    btn.tapBlock = blk;
    return btn;
}