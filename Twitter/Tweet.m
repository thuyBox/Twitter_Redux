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
        if (dictionary[@"retweet_count"]) {
            self.retweetCount = @([dictionary[@"retweet_count"] longValue]);
        } else {
            self.retweetCount = @(0);
        }
        
        if (dictionary[@"favorite_count"]) {
            self.favourites_count = @([dictionary[@"favorite_count"] longValue]);
        } else {
            self.favourites_count = @(0);
        }
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        
        if (dictionary[@"in_reply_to_status_id"] != [NSNull null]) {
            self.inReplyToStatusId = @([dictionary[@"in_reply_to_status_id"] longValue]);
        }
        
        if (dictionary[@"in_reply_to_screen_name"] != [NSNull null]) {
            self.inReplyToScreenName = dictionary[@"in_reply_to_screen_name"];
        }
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

/*- (NSString*) convertObjectToJsonString {
    NSError *writeError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return result;
}*/
@end
