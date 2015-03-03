//
//  TweetUpdateDelegate.h
//  Twitter
//
//  Created by Thuy Nguyen on 3/3/15.
//  Copyright (c) 2015 test. All rights reserved.
//

@protocol TweetUpdateDelegate <NSObject>

- (void) updateTweet:(Tweet *)tweet oldTweet:(Tweet *)oldTweet;
- (void) addTweet:(Tweet *)tweet;
- (void) presentReplyTweet:(Tweet *)tweet;

@end
