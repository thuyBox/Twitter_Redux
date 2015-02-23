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

@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nameLabel.text = self.tweet.user.name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.tweetLabel.text = self.tweet.text;
    NSDateFormatter *dateformater =[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"MM/d/y"]; // Date formater
    self.createdAtLabel.text = [dateformater stringFromDate:self.tweet.createdAt];
    
    //UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
   // self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.hidesBackButton = NO;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.retweetButton.backgroundColor = [UIColor clearColor];
    self.replyButton.backgroundColor = [UIColor clearColor];
    self.favoriteButton.backgroundColor = [UIColor clearColor];
    
    self.retweetLabel.text = [NSString stringWithFormat:@"%@ RETWEETS", self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%@ FAVORITES", self.tweet.favourites_count];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onReply:(id)sender {
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (IBAction)onFavorite:(id)sender {
}
@end
