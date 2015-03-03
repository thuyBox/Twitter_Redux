//
//  TweetViewController.h
//  Twitter
//
//  Created by Baeksan Oh on 2/23/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TwitterTimelineViewController.h"

@protocol TweetViewController <NSObject>

- (void)updateTweet:(Tweet *)tweet oldTweet:(Tweet *)oldTweet;

@end

@interface TweetViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UIButton *replyButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *favoriteLabel;
- (IBAction)onReply:(id)sender;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFavorite:(id)sender;

@property (strong, nonatomic) id<TweetViewController> delegate;
@property (strong, nonatomic) id<TweetUpdateDelegate> tweetsDelegate;
@end
