//
//  TweetViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/23/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "TweetViewController.h"

#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "ComposeTweetViewController.h"
#import "TwitterTimelineViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nameLabel.text = self.tweet.user.name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    NSDateFormatter *dateformater =[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"MM/d/y"]; // Date formater
    self.createdAtLabel.text = [dateformater stringFromDate:self.tweet.createdAt];
    self.navigationItem.hidesBackButton = NO;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self setupButtons];
}

- (void)setupButtons {
    self.retweetButton.backgroundColor = [UIColor clearColor];
    self.replyButton.backgroundColor = [UIColor clearColor];
    self.favoriteButton.backgroundColor = [UIColor clearColor];
    
    self.retweetLabel.text = [NSString stringWithFormat:@"%@ RETWEETS", self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%@ FAVORITES", self.tweet.favourites_count];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReply:(id)sender {
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    vc.toBeRepliedTweet = self.tweet;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onRetweet:(id)sender {
    if (self.tweet.retweeted) {
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet_on.png"] forState:UIControlStateNormal];
    } else {
        [[TwitterClient sharedInstance] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (!error) {
                //TwitterTimelineViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
                [self.tweetsDelegate addTweet:tweet];
                self.tweet.retweetCount = @([self.tweet.retweetCount intValue] + 1);
                self.tweet.retweeted = YES;
                [self.tweetsDelegate updateTweet:self.tweet oldTweet:self.tweet];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                NSLog(@"error retweeting in tweetVC: %@", error);
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
            //TwitterTimelineViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
            self.tweet.favourites_count = @([self.tweet.favourites_count intValue] + 1);
            self.tweet.favorited = YES;
            [self.tweetsDelegate updateTweet:self.tweet oldTweet:self.tweet];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}
@end
