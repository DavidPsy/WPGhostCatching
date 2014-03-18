//
//  WPDataDetails.m
//  WPGuess
//
//  Created by psy on 14-3-14.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "WPDataDetails.h"

@implementation WPRole

- (NSDictionary*)convertToDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"peerId"] = _peerId;
    dict[@"word"] = _word;
    dict[@"roleType"] = @(_roleType);
    dict[@"roleStatus"] = @(_roleStatus);
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (id)initWithDict:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        _peerId = dict[@"peerId"];
        _word = dict[@"word"];
        _roleType = [dict[@"roleType"] intValue];
        _roleStatus = [dict[@"roleStatus"] intValue];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_peerId forKey:@"peerId"];
    [aCoder encodeObject:_word forKey:@"word"];
    [aCoder encodeObject:@(_roleType) forKey:@"roleType"];
    [aCoder encodeObject:@(_roleStatus) forKey:@"roleStatus"];
    [aCoder encodeObject:_roleName forKey:@"roleName"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _peerId = [aDecoder decodeObjectForKey:@"peerId"];
        _word = [aDecoder decodeObjectForKey:@"word"];
        _roleType = [[aDecoder decodeObjectForKey:@"roleType"] intValue];
        _roleStatus = [[aDecoder decodeObjectForKey:@"roleStatus"] intValue];
        _roleName = [aDecoder decodeObjectForKey:@"roleName"];
    }
    return self;
}

@end
