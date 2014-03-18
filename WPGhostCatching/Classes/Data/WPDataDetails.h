//
//  WPDataDetails.h
//  WPGuess
//
//  Created by psy on 14-3-14.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WPRoleTypeServer,
    WPRoleTypePlayer,
}WPRoleType;

typedef enum {
    WPRoleStatusAlive,
    WPRoleStatusDead,
}WPRoleStatus;

@interface WPRole : NSObject<NSCoding>

@property (nonatomic,copy) NSString* peerId;
@property (nonatomic,copy) NSString* word;
@property (nonatomic,assign) WPRoleType roleType;
@property (nonatomic,assign) WPRoleStatus roleStatus;
@property (nonatomic, strong) NSString *roleName;

- (NSDictionary*)convertToDict;
- (id)initWithDict:(NSDictionary*)dict;

@end

@interface WPRoom : NSObject

@property (nonatomic,copy) NSString* masterID;
@property (nonatomic,copy) NSString* roomName;
@property (nonatomic,copy) NSMutableArray *roleList;

@end
