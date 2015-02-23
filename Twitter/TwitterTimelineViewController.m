//
//  TwitterTimelineViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "TwitterTimelineViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeTweetViewController.h"
#import "TweetViewController.h"

@interface TwitterTimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TwitterTimelineViewController

- (void)viewDidLoad {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tweets = [[NSArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.estimatedRowHeight = 104;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Add refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self onRefresh];
    
    self.title = @"Home";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(composeTweet)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [super viewDidLoad];
}

- (void)onRefresh {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet *tweet in tweets) {
            NSLog(@"current tweet=%@, created=%@", tweet.text, tweet.createdAt);
        }
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void) composeTweet {
    NSLog(@"composing tweet");
    
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}
- (void) logout {
    [User setUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    if (cell == nil) {
        cell = [[TweetCell alloc] init];
    }
    Tweet * tweet = self.tweets[indexPath.row];
    cell.nameLabel.text = tweet.user.name;
    cell.tweetLabel.text = tweet.text;
    NSDateFormatter *dateformater =[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"MM/d/y"]; // Date formater
    cell.createdAtLabel.text = [dateformater stringFromDate:tweet.createdAt]; // Convert date to string
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    cell.screenNameLabel.text = tweet.user.screenName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewController *vc = [[TweetViewController alloc] init];
    
    vc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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

@end
