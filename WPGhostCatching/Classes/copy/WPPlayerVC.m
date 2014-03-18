//
//  WPRoomVC.m
//  WPGuess
//
//  Created by psy on 14-3-14.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPPlayerVC.h"
#import "WPRoleScrollView.h"
#import "WPDataCenter.h"

@interface WPPlayerVC ()

@property (nonatomic, strong) UIButton *guessWordButton;
@property (nonatomic, strong) WPRoleScrollView *roleScrollView;

@end

@implementation WPPlayerVC
{
    BOOL _hideGuessWord;
    NSString *_keyWord;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [WPDataCenter shareInstance].localPlayerName;
    
    [self.guessWordButton setTitle:@"准备" forState:UIControlStateNormal];
    _keyWord = @"角色名字";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePlayerChangeNotification:) name:@"kPlayerChangeNotification" object:nil];
}

#pragma mark -- methods

- (void)receivePlayerChangeNotification:(NSNotification *)notification
{
    self.guessWordButton.enabled = YES;
    NSDictionary *userInfo = (NSDictionary *)(notification.userInfo);
    if ([userInfo[@"type"] intValue] == WPRoleStatusAlive) {
        NSDictionary *playersDictionary = userInfo[@"players"];
        GKSession *currentSession = [[WPDataCenter shareInstance] session];
        WPRole *currentRole = playersDictionary[currentSession.peerID];
        _keyWord = currentRole.word;
        [self.guessWordButton setTitle:_keyWord forState:UIControlStateNormal];
        
        NSMutableArray *playersArray = [NSMutableArray array];
        NSMutableArray *playersPeerIDsArray = [NSMutableArray array];
        for (NSString *key in playersDictionary.allKeys) {
            WPRole *role = playersDictionary[key];
            [playersArray addObject:role.roleName];
            [playersPeerIDsArray addObject:role.peerId];
        }
        self.roleScrollView.playerPeerIDs = [NSArray arrayWithArray:playersPeerIDsArray];
        [self.roleScrollView setRoles:[NSArray arrayWithArray:playersArray]];
    } else if ([userInfo[@"type"] intValue] == WPRoleStatusDead) {
        NSString *peerID = userInfo[@"peerID"];
        [self.roleScrollView killUserAtPeerID:peerID];
    }
}

- (void)didClickGuessWordButton:(id)sender
{
    _hideGuessWord = !_hideGuessWord;
    if (_hideGuessWord) {
        [self.guessWordButton setTitle:@"显示角色" forState:UIControlStateNormal];
    } else {
        [self.guessWordButton setTitle:_keyWord forState:UIControlStateNormal];
    }
}

#pragma mark -- getter/setter methods

- (UIButton *)guessWordButton
{
    if (_guessWordButton == nil) {
        _guessWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _guessWordButton.frame = CGRectMake(60, 100, 200, 40);
        _guessWordButton.backgroundColor = [UIColor orangeColor];
        [_guessWordButton addTarget:self action:@selector(didClickGuessWordButton:) forControlEvents:UIControlEventTouchUpInside];
        _guessWordButton.enabled = NO;
        [self.view addSubview:_guessWordButton];
    }
    return _guessWordButton;
}

- (WPRoleScrollView *)roleScrollView
{
    if (_roleScrollView == nil) {
        UILabel *listViewNameLabel = [UILabel labelWithFrame:CGRectMake(0, self.guessWordButton.bottom + 20, 320, 40) font:Font(20) andTextColor:HEXCOLOR(0x333333)];
        listViewNameLabel.text = @"用户列表";
        listViewNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:listViewNameLabel];
        _roleScrollView = [[WPRoleScrollView alloc] initWithFrame:CGRectMake(0, listViewNameLabel.bottom, self.view.width, self.view.height - listViewNameLabel.bottom)];
        [self.view addSubview:_roleScrollView];
    }
    return _roleScrollView;
}

@end
