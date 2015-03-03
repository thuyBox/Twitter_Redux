//
//  ProfileViewController.m
//  Twitter
//
//  Created by Baeksan Oh on 2/27/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import "ContainerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ProfileViewController () <ProfileCellDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (strong, nonatomic) ProfileCell *header;

@end

@implementation ProfileViewController


- (ProfileViewController *)initWithParentContainerViewController:(ContainerViewController *)parentContainerViewController {
    self = [super init];
    if (self) {
        self.parentContainerViewController = parentContainerViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavigationBarStyle];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCell"];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    [self.bannerImageView setImageWithURL:[NSURL URLWithString:self.user.profileBannerUrl]];
    [self onProfileDataSourceChanged:ProfileDataSourceIndexTweets];
}

- (void)setNavigationBarStyle {
    if (self.user.profileImageUrl) {
        self.title = @"";
    } else {
        self.title = @"Profile";
    }
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
    // Set navigation bar style to be transparent
    // http://stackoverflow.com/questions/19082963/how-to-make-completely-transparent-navigation-bar-in-ios-7
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

#pragma mark UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 155;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.header == nil) {
        self.header = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
        self.header.user = self.user;
        self.header.delegate = self;
    }
    return self.header;
}

- (void)onRefresh {
}

#pragma mark ProfileCellDelegate

- (void)onProfileDataSourceChanged:(ProfileDataSourceIndex)index {
    NSLog(@"onProfileDataSourceChanged index=%ld", index);
    [self loadTimelineWithParams:nil dataSourceIndex:index];
}

- (void)loadTimelineWithParams:(NSMutableDictionary *)params dataSourceIndex:(ProfileDataSourceIndex)dataSourceIndex{
    NSMutableDictionary *finalParams = params;
    
    if (finalParams == nil) {
        finalParams = [[NSMutableDictionary alloc] init];
        [finalParams setObject:@([self.user.userId integerValue]) forKey:@"user_id"];
        [finalParams setObject:@(20) forKey:@"count"];
    }
    
    void (^handleLoadCompletion)(NSArray *, NSError *) = ^(NSArray *tweets, NSError *error){
        if (!error) {
            self.tweets = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
        } else {
            NSLog(@"failed to load home timeline data with error %@", error);
        }
    };
    
    if (dataSourceIndex == ProfileDataSourceIndexTweets) {
        [[TwitterClient sharedInstance] userTimelineWithParams:finalParams completion:handleLoadCompletion];
    } else if (dataSourceIndex == ProfileDataSourceIndexFavorites) {
        [[TwitterClient sharedInstance] userFavoritesWithParams:finalParams completion:handleLoadCompletion];
    }
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
