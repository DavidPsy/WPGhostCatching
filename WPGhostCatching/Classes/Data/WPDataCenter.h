//
//  WPDataCenter.h
//  WPGuess
//
//  Created by psy on 14-3-14.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPDataDetails.h"

@interface WPDataCenter : NSObject <GKSessionDelegate>

@property (nonatomic,strong) NSMutableArray *roleList;

@property (nonatomic,assign)BOOL isServer;
@property (nonatomic,copy)NSString* localPlayerName;
@property (nonatomic, strong) GKSession *session;

@property (nonatomic,copy)NSString* ghostWords;
@property (nonatomic,copy)NSString* playerWords;

+ (WPDataCenter*)shareInstance;

- (void)startServerGameWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients;
- (void)startClientGameWithSession:(GKSession *)session playerName:(NSString *)name server:(NSString *)peerID;
- (void)killClientWithPeerID:(NSString *)peerID;

@end
