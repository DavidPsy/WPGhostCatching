//
//  WPPlayersList.m
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPPlayersList.h"
#import "WPDataCenter.h"
#import "WPQuickComponents.h"

@interface WPPlayersList ()

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) WPButton *currentUser;

@end

@implementation WPPlayersList {
    GKSession *_session;
}

- (id)init {
    self = [super init];
    if (self) {
        _buttonsArray = [NSMutableArray array];
        _session = [WPDataCenter shareInstance].session;
        
//        self.contentSizeType = CCSizeTypeNormalized;
//        self.contentSize = CGSizeMake(1, 1);
    }
    return self;
}

- (void)setRoles:(NSArray *)rolesArray
{
    
    CGFloat kOffsetX = 20;
    CGFloat kButtonWidth = 280;
    CGFloat kTop = 20;
    NSUInteger rolesArrayCount = [rolesArray count];
    for (int i = 0;i < rolesArrayCount;i++) {
        WPButton *btn = makeButton(rolesArray[i], WPFontNormal, ccp(kOffsetX + kButtonWidth/2, kTop + i * (40 + kOffsetX)), ^{
            if (_canClickUser) {
                self.currentUser = btn;
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
            
        });
        btn.contentSize = CGSizeMake(kButtonWidth, 40);
        
        [self.buttonsArray addObject:btn];
        [self addChild:btn];
    }
//    self.contentSize = CGSizeMake(320, 200);
}

#pragma mark -- methods

- (void)killUserAtPeerID:(NSString *)peerID
{
    for (WPButton *button in self.buttonsArray) {
        CCLOG(@"killUserAtPeerID");
//        if ([button.peerID isEqualToString:peerID]) {
//            button.backgroundColor = [UIColor grayColor];
//            break;
//        }
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
//    [self.currentUser setBackgroundColor:[UIColor grayColor]];
//    if (_completeBlock) {
//        _completeBlock(self.currentUser.peerID);
//    }
}

@end
