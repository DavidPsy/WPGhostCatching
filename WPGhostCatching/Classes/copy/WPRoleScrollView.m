//
//  WPRoleScrollView.m
//  WPGuess
//
//  Created by wangxu on 14-3-14.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPRoleScrollView.h"
#import "MTAlertView.h"
#import "WPDataCenter.h"
#import "WPButton.h"

@interface WPRoleScrollView ()

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) WPButton *currentUser;

@end

@implementation WPRoleScrollView {
    GKSession *_session;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.buttonsArray = [NSMutableArray array];
        _session = [WPDataCenter shareInstance].session;
    }
    return self;
}

- (void)setRoles:(NSArray *)rolesArray
{
//    NSMutableArray *rolesArray = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
//        [rolesArray addObject:[@(i) stringValue]];
//    }
//    
//    [self.buttonsArray removeAllObjects];
    CGFloat kOffsetX = 20;
    CGFloat kButtonWidth = 280;
    CGFloat kTop = 20;
    NSUInteger rolesArrayCount = [rolesArray count];
    for (int i = 0;i < rolesArrayCount;i++) {
        WPButton *roleButton = [WPButton buttonWithType:UIButtonTypeCustom];
        roleButton.frame = CGRectMake(kOffsetX , kTop + i * (40 + kOffsetX), kButtonWidth, 40);
        roleButton.peerID = self.playerPeerIDs[i];
        roleButton.backgroundColor = [UIColor orangeColor];
        [roleButton addTarget:self action:@selector(didClickRoleButton:) forControlEvents:UIControlEventTouchUpInside];
        [roleButton setTitle:rolesArray[i] forState:UIControlStateNormal];
//        [roleButton setTitle:[_session displayNameForPeer:rolesArray[i]] forState:UIControlStateNormal];
        if (!_canClickUser) {
            roleButton.enabled = NO;
        }
        [self.buttonsArray addObject:roleButton];
        [self addSubview:roleButton];
    }
    self.contentSize = CGSizeMake(self.width, MAX(self.height, kTop + (rolesArrayCount) * (kButtonWidth + kOffsetX)));
}

#pragma mark -- methods

- (void)killUserAtPeerID:(NSString *)peerID
{
    for (WPButton *button in self.buttonsArray) {
        if ([button.peerID isEqualToString:peerID]) {
            button.backgroundColor = [UIColor grayColor];
            break;
        }
    }
}

- (void)didClickRoleButton:(id)sender
{
    self.currentUser = (WPButton *)sender;
    MTAlertView* alertView = [[MTAlertView alloc] initWithTitle:nil
                                                        message:@"确定用户已死"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
    [alertView addTarget:self
                  action:@selector(didKillUser)
                forTitle:@"确定"];
    [alertView show];
}

- (void)didKillUser
{
    self.currentUser.enabled = NO;
    [self.currentUser setBackgroundColor:[UIColor grayColor]];
    if (_completeBlock) {
        _completeBlock(self.currentUser.peerID);
    }
}

@end
