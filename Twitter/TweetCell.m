//
//  TweetCell.m
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterClient.h"
#import "ComposeTweetViewController.h"
//#import "TwitterTimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    
    self.profileImageView.layer.cornerRadius = 3;
    self.profileImageView.clipsToBounds = YES;
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileImageTap)];
    [profileTapGestureRecognizer setNumberOfTouchesRequired:1];
    [profileTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self setupButtons];
    
    self.nameLabel.text = tweet.user.name;
    self.tweetLabel.text = tweet.text;
    self.createdAtLabel.text = tweet.createdAt.shortTimeAgoSinceNow;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    NSString *details = @"";
    if (tweet.retweeted) {
        details = [details stringByAppendingString:@" retweeted"];
    } else if (tweet.inReplyToStatusId) {
        details = [details stringByAppendingString:[NSString stringWithFormat:@" in reply to @%@", tweet.inReplyToScreenName]];
    }
    self.additionalDetailsLabel.text = details;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%@", self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%@", self.tweet.favourites_count];
}

- (void)setupButtons {
    self.retweetButton.backgroundColor = [UIColor clearColor];
    self.replyButton.backgroundColor = [UIColor clearColor];
    self.favoriteButton.backgroundColor = [UIColor clearColor];
    
    NSString *currentUserName = [User user].name;
    NSString *tweetAuthor = self.tweet.user.name;
    if (self.tweet.inReplyToStatusId == nil && ![tweetAuthor isEqualToString:currentUserName]) {
        self.retweetButton.enabled = YES;
        self.replyButton.enabled = YES;
    } else {
        self.retweetButton.enabled = NO;
        self.replyButton.enabled = NO;
    }
    
    if (self.tweet.retweeted) {
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet_on.png"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.favorited) {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite_on.png"] forState:UIControlStateNormal];
    } else {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    }
    
    [self.replyButton setBackgroundImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
}

- (void)onProfileImageTap {
    NSLog(@"cell delegate=%@", self.delegate);
    [self.delegate onProfileImageTap:self.tweet.user];
}


- (IBAction)onReply:(id)sender {
    [self.tweetsDelegate presentReplyTweet:self.tweet];
    /*ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    vc.toBeRepliedTweet = self.tweet;
    UINavigationController *nvc = (UINavigationController *)self.window.rootViewController;
    [nvc pushViewController:vc animated:YES];*/
}

- (IBAction)onRetweet:(id)sender {
    if (self.tweet.retweeted) {
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet_on.png"] forState:UIControlStateNormal];
    } else {
        [[TwitterClient sharedInstance] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (!error) {
            //UINavigationController *nvc = (UINavigationController *)self.window.rootViewController;
            //TwitterTimelineViewController *vc = [nvc.viewControllers objectAtIndex:0];
            [self.tweetsDelegate addTweet:tweet];
            self.tweet.retweetCount = @([self.tweet.retweetCount intValue] + 1);
            self.tweet.retweeted = YES;
            [self.tweetsDelegate updateTweet:self.tweet oldTweet:self.tweet];
            //[nvc popToRootViewControllerAnimated:YES];
            } else {
                NSLog(@"Error retweet from timeline %@", error);
            }
        }];
    }
}

- (IBAction)onFavorite:(id)sender {
    if (self.tweet.favorited) {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite_on.png"] forState:UIControlStateNormal];
    } else {
        [[TwitterClient sharedInstance] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            NSLog(@"finished favoriting tweet %@", tweet);
            //UINavigationController *nvc = (UINavigationController *)self.window.rootViewController;
            //TwitterTimelineViewController *vc = [nvc.viewControllers objectAtIndex:0];
            self.tweet.favourites_count = @([self.tweet.favourites_count intValue] + 1);
            self.tweet.favorited = YES;
            [self.tweetsDelegate updateTweet:self.tweet oldTweet:self.tweet];
            //[nvc popToRootViewControllerAnimated:YES];
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tweetLabel.preferredMaxLayoutWidth = self.bounds.size.width;
    
    //[self setupButtons];
}

@end
