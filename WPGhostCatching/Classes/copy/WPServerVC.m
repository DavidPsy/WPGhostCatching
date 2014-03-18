//
//  WPRoleViewController.m
//  testGame
//
//  Created by wangxu on 14-3-14.
//  Copyright (c) 2014年 wangxu. All rights reserved.
//

#import "WPServerVC.h"
#import "WPRoleScrollView.h"
#import "MTAlertView.h"
#import "WPDataDetails.h"
#import "WPDataCenter.h"

@interface WPServerVC ()

@property (nonatomic, weak) IBOutlet UITextField *ghostField;
@property (nonatomic, weak) IBOutlet UITextField *playerField;
@property (nonatomic, weak) IBOutlet UIButton *hideButton;
@property (nonatomic, strong) WPRoleScrollView *roleScrollView;

- (IBAction)onHide:(id)sender;

@end

@implementation WPServerVC {
    BOOL _isHide;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回到首页" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItem)];
    
    [self resetTxtWithHideStatus:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.roleScrollView.playerPeerIDs = self.playerPeerIDs;
    [self.roleScrollView setRoles:self.players];
}

#pragma mark -- methods

- (void)didClickBackButtonItem
{
    MTAlertView* alertView = [[MTAlertView alloc] initWithTitle:nil
                                                        message:@"确认销毁房间"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
    [alertView addTarget:self
                  action:@selector(didExitRoom)
                forTitle:@"确定"];
    [alertView show];
}

- (void)didExitRoom
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onHide:(id)sender {
    [self resetTxtWithHideStatus:!_isHide];
}

- (void)resetTxtWithHideStatus:(BOOL)isHide {
    _isHide = isHide;
    
    NSString *txt = _isHide ? @"显示" : @"隐藏";
    [self.hideButton setTitle:txt forState:UIControlStateNormal];
    
    if (_isHide) {
        self.ghostField.text = @"";
        self.playerField.text = @"";
    } else {
        self.ghostField.text = [WPDataCenter shareInstance].ghostWords;
        self.playerField.text = [WPDataCenter shareInstance].playerWords;
    }
}

#pragma mark -- getter/setter methods

- (WPRoleScrollView *)roleScrollView
{
    if (_roleScrollView == nil) {
        UILabel *listViewNameLabel = [UILabel labelWithFrame:CGRectMake(0, self.hideButton.bottom + 20, 320, 40) font:Font(20) andTextColor:HEXCOLOR(0x333333)];
        listViewNameLabel.text = @"用户列表";
        listViewNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:listViewNameLabel];
        _roleScrollView = [[WPRoleScrollView alloc] initWithFrame:CGRectMake(0, listViewNameLabel.bottom, self.view.width, self.view.height - listViewNameLabel.bottom)];
        _roleScrollView.canClickUser = YES;
        _roleScrollView.completeBlock = ^(NSString *peerID) {
            WPDataCenter *dataCenter = [WPDataCenter shareInstance];
            [dataCenter killClientWithPeerID:peerID];
        };
        [self.view addSubview:_roleScrollView];
    }
    return _roleScrollView;
}

@end
