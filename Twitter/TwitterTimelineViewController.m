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

@interface TwitterTimelineViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property long currentIndex;
@end

@implementation TwitterTimelineViewController

- (TwitterTimelineViewController *)initWithParentContainerViewController:(ContainerViewController *)parentContainerViewController {
    self = [super init];
    if (self) {
        self.parentContainerViewController = parentContainerViewController;
        NSLog(@"assign TwitterTimelineViewController's parentContainerViewController %@", parentContainerViewController);
    }
    return self;
}

- (void)viewDidLoad {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tweets = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.estimatedRowHeight = 120;
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

- (void) addTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (void) updateTweet:(Tweet *)tweet oldTweet:(Tweet *)oldTweet {
    long index = [self.tweets indexOfObject:oldTweet];
    //self.currentIndex;
    self.tweets[index] = tweet;
    [self.tableView reloadData];
}

- (void)onRefresh {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet *tweet in tweets) {
            NSLog(@"current tweet=%@, created=%@", tweet.text, tweet.createdAt);
        }
        self.tweets = [NSMutableArray arrayWithArray:tweets];
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
    /*[User setUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];*/
    [User logout];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.delegate = self.parentContainerViewController;
    Tweet * tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
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
