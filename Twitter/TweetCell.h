//
//  TweetCell.h
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

@protocol TweetCellDelegate <NSObject>
- (void)onProfileImageTap:(User *)user;
@end

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *additionalDetailsLabel;
@property (strong, nonatomic) IBOutlet UIButton *replyButton;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *favoriteCountLabel;
- (IBAction)onReply:(id)sender;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFavorite:(id)sender;
- (void)setupButtons;
//- (IBAction)onProfileImageTap:(UITapGestureRecognizer *)sender;
@property (strong, nonatomic, readwrite) Tweet *tweet;

@property (strong, nonatomic) id<TweetCellDelegate> delegate;

@end
