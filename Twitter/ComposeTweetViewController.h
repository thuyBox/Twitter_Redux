//
//  ComposeTweetViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/23/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TwitterTimelineViewController.h"

@interface ComposeTweetViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITextView *tweetTextView;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) Tweet *toBeRepliedTweet;
@property (strong, nonatomic) id<TweetUpdateDelegate> tweetsDelegate;
@end
