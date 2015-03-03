//
//  TwitterClient.h
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *) sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError* error))completion;

- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray * tweets, NSError *error))completion;

- (void)mentionsWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)userTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)userFavoritesWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)tweet:(NSString *)text completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void)reply:(Tweet *)tweet text:(NSString *)text completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *tweet, NSError *error))completion;
@end
