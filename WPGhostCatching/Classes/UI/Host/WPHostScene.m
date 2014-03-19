//
//  WPHostScene.m
//  WPGhostCatching
//
//  Created by psy on 14-3-19.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPHostScene.h"
#import "WPHomeScene.h"

#import "WPPlayersList.h"

@implementation WPHostScene

- (id)init {
    self = [super init];
    if (self) {
        WPButton *backBtn = makeButton(@"back", WPFontNormal, ccp(0.2, 0.2), ^{
            sceneBack([[WPHomeScene alloc] init]);
        });
        [self addChild:backBtn];
        
        NSArray *strs = @[@"tom",@"jim",@"david",@"alice",@"wer"];
//        WPPlayersList *pnode = [WPPlayersList node];
//        [pnode setRoles:strs];
//        pnode.position = ccp(0.5, 0.5);
//        [self addChild:pnode];
        
        NSArray *rolesArray = @[@"tom",@"jim",@"david",@"alice",@"wer"];
        
        CGFloat kOffsetX = 0.1f;
        NSUInteger rolesArrayCount = [rolesArray count];
        for (int i = 0; i < rolesArrayCount; i++) {
            
            int row = i / 4 ;
            int col = i % 4 ;
            
            WPButton *btn = makeButton(rolesArray[i], WPFontNormal, ccp(0.1f + 0.2 * col, 0.4f + 0.2 * row), ^{
                if (YES) {
//                    self.currentUser = btn;
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
            [btn setBackgroundColor:ccWHITE forState:CCControlStateNormal];
            
//            btn.contentSize = CGSizeMake(kButtonWidth, 40);
            
//            [self.buttonsArray addObject:btn];
            [self addChild:btn];
        }
        
    }
    return self;
}

- (void)onEnter {
    
}

@end
