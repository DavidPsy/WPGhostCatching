//
//  WPRoleViewController.h
//  testGame
//
//  Created by wangxu on 14-3-14.
//  Copyright (c) 2014年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPServerVC : UIViewController <GKSessionDelegate>

@property (nonatomic, strong) NSArray *playerPeerIDs;
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) GKSession *session;

@end

