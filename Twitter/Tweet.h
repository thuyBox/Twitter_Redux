//
//  Tweet.h
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSNumber *tweetId;
@property (nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, strong) NSNumber *favourites_count;
@property BOOL retweeted;
@property BOOL favorited;

- (id) initWithDictionary: (NSDictionary *)dictionary;
+ (NSArray *) tweetsWithArray: (NSArray *)array;
@end
