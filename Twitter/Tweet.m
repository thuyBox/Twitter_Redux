//
//  Tweet.m
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
- (id) initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y"; //"Mon Feb 23 05:47:05 +0000 2015"
        self.createdAt = [formatter dateFromString:createdAtString];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.tweetId = @([dictionary[@"id"] longValue]);
        self.retweetCount = @([dictionary[@"retweet_count"] longValue]);
        self.favourites_count = @([dictionary[@"favourites_count"] longValue]);
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
    }
    
    return self;
}

+ (NSArray *) tweetsWithArray: (NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}
@end
