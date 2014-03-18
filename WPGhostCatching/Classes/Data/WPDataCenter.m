//
//  WPDataCenter.m
//  WPGuess
//
//  Created by psy on 14-3-14.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPDataCenter.h"

@implementation WPDataCenter {
    GKSession *_session;
	NSString *_serverPeerID;
    NSMutableDictionary *_players;
    
    NSMutableSet *_matchingPlayers;
}

+ (WPDataCenter*)shareInstance {
    static WPDataCenter* dataCenter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCenter = [[self alloc] init];
    });
    
    return dataCenter;
}

- (id)init
{
	if ((self = [super init]))
	{
		_players = [NSMutableDictionary dictionaryWithCapacity:4];
		_matchingPlayers = [NSMutableSet setWithCapacity:4];
        _ghostWords = @"ghost";
        _playerWords = @"player";
	}
	return self;
}

- (void)startServerGameWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients {
    _isServer = YES;
    
    _session = session;
	_session.available = NO;
	_session.delegate = self;
	[_session setDataReceiveHandler:self withContext:nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"server"] = _session.peerID;
    dict[@"type"] = @(WPRoleStatusAlive);
    [_players removeAllObjects];
    NSMutableArray *sourceClientsArray = [clients mutableCopy];
    int total = [sourceClientsArray count];
    int count = 1;
    if (total > 5 && total < 10) {
        count = 2;
    } else if (total >= 10) {
        count = total / 3;
    }
    for (int i = 0; i < count; i++) {
        int t = rand() % [sourceClientsArray count];
        WPRole *arole = [[WPRole alloc] init];
        arole.peerId = sourceClientsArray[t];
        arole.word = self.ghostWords;
        arole.roleName = [_session displayNameForPeer:arole.peerId];
        [_players setObject:arole forKey:arole.peerId];
        [sourceClientsArray removeObject:sourceClientsArray[t]];
    }
    
    for (NSString *peedId in sourceClientsArray) {
        WPRole *arole = [[WPRole alloc] init];
        arole.peerId = peedId;
        arole.word = self.playerWords;
        arole.roleName = [_session displayNameForPeer:arole.peerId];
        [_players setObject:arole forKey:arole.peerId];
    }
    
    dict[@"players"] = [_players mutableCopy];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
	NSError *error;
	if (![_session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error])
	{
		NSLog(@"Error sending data to clients: %@", error);
	}
    
}
- (void)startClientGameWithSession:(GKSession *)session playerName:(NSString *)name server:(NSString *)peerID {
    _isServer = NO;
    
    _session = session;
	_session.available = NO;
	_session.delegate = self;
	[_session setDataReceiveHandler:self withContext:nil];
    
    _serverPeerID = peerID;
	_localPlayerName = name;
}

- (void)killClientWithPeerID:(NSString *)peerID
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"peerID"] = peerID;
    dict[@"type"] = @(WPRoleStatusDead);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
	NSError *error;
	if (![_session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error])
	{
		NSLog(@"Error sending data to clients: %@", error);
	}
}


#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
#ifdef DEBUG
	NSLog(@"Game: peer %@ changed state %d", peerID, state);
#endif
	
	if (state == GKPeerStateDisconnected)
	{
		if (self.isServer)
		{
//			[self clientDidDisconnect:peerID redistributedCards:nil];
		}
		else if ([peerID isEqualToString:_serverPeerID])
		{
//			[self quitGameWithReason:QuitReasonConnectionDropped];
		}
	}
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
#ifdef DEBUG
	NSLog(@"Game: connection request from peer %@", peerID);
#endif
    
	[session denyConnectionFromPeer:peerID];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"Game: connection with peer %@ failed %@", peerID, error);
#endif
    
	// Not used.
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
#ifdef DEBUG
	NSLog(@"Game: session failed %@", error);
#endif
    
	if ([[error domain] isEqualToString:GKSessionErrorDomain])
	{
//		if (_state != GameStateQuitting)
//		{
//			[self quitGameWithReason:QuitReasonConnectionDropped];
//		}
	}
}

#pragma mark - GKSession Data Receive Handler

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peerID inSession:(GKSession *)session context:(void *)context
{
#ifdef DEBUG
	NSLog(@"Game: receive data from peer: %@, data: %@, length: %d", peerID, data, [data length]);
#endif
    
    /**
     先做package检测
     然后 if server，server 处理
            else  client 处理
     
     */
    
    if (data == nil) {
        return;
    }
    
    if (_isServer) {
        return;
    }
    
    NSDictionary *adict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    NSString *serverPeerID = adict[@"server"];
    if ([adict.allKeys count] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kPlayerChangeNotification" object:nil userInfo:adict];
    }
    
}

@end
