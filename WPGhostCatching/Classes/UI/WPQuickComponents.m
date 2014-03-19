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
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.3f]];
}

void sceneBack(CCScene *toScene) {
    [[CCDirector sharedDirector] replaceScene:toScene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.3f]];
}

#pragma mark - 

WPButton* makeButton(NSString *title, float fontSize,CGPoint pos,WPTapBlock blk) {
    WPButton *btn = [WPButton buttonWithTitle:title fontName:@"Verdana-Bold" fontSize:fontSize];
    btn.positionType = CCPositionTypeNormalized;
    btn.position = pos;
    btn.tapBlock = blk;
    return btn;
}

#pragma mark - 

CCNode* makeLayer() {
    CCNode *n = [CCNode node];
    n.contentSizeType = CCSizeTypeNormalized;
    n.contentSize = CGSizeMake(1, 1);
    
//    CCSprite9Slice* headerBg = [CCSprite9Slice spriteWithImageNamed:@"Interface/header.png"];
//    headerBg.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft);
//    headerBg.position = ccp(0,0);
//    headerBg.anchorPoint = ccp(0,1);
//    headerBg.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitPoints);
//    headerBg.contentSize = CGSizeMake(1, 44);
//    
//    [n addChild:headerBg];
    
    return n;
}