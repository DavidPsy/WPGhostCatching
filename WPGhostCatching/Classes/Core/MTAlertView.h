//
//  MTAlertView.h
//  MTFramework
//
//  Created by 李 帅 on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTAlertView : UIAlertView <UIAlertViewDelegate>

/**
 * 给AlertView中对应title的button添加相应的响应事件。
 * @params target, 事件的接受者。
 * @params selector, 响应事件的名称。
 * @params title, 对应button的名称。
 */

- (void)addTarget:(id)target action:(SEL)selector forTitle:(NSString *)title;

@end


#define MTAlert(s)          UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:s delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]; [alert show];
#define MTAlertDetail(t, s) UIAlertView * alert = [[UIAlertView alloc] initWithTitle:t message:s delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]; [alert show];