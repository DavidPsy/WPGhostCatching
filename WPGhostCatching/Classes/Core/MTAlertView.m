//
//  MTAlertView.m
//  MTFramework
//
//  Created by 李 帅 on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MTAlertView.h"


@interface MTAlertView ()

@property (nonatomic, retain) NSMutableDictionary *actionPairs;

@end

@implementation MTAlertView

- (NSMutableDictionary *)actionPairs
{
    if (_actionPairs == nil) {
        _actionPairs = [[NSMutableDictionary alloc] init];
    }
    return _actionPairs;
}

- (void)addTarget:(id)target action:(SEL)selector forTitle:(NSString *)title
{
    self.delegate = self;
    NSMethodSignature *sig = [target methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:target];
        [invo setSelector:selector];
        if (sig.numberOfArguments > 2) {
            [invo setArgument:&title atIndex:2];
        }
        
        [self.actionPairs setObject:invo forKey:title];
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [self buttonTitleAtIndex:buttonIndex];
    NSInvocation *invo = [self.actionPairs objectForKey:title];
    [invo invoke];
}

@end
