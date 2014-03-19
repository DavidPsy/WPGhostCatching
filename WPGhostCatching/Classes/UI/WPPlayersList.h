//
//  WPPlayersList.h
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "CCScrollView.h"

@interface WPPlayersList : CCNodeColor

@property (nonatomic, strong) NSArray *playerPeerIDs;
@property (nonatomic, assign) BOOL canClickUser;
@property (nonatomic, copy) void(^completeBlock)(NSString *peerID);

- (void)setRoles:(NSArray *)rolesArray;
- (void)killUserAtPeerID:(NSString *)peerID;


@end
