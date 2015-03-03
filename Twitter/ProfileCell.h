//
//  ProfileCell.h
//  Twitter
//
//  Created by Thuy Nguyen on 3/1/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef NS_ENUM(NSInteger, ProfileDataSourceIndex) {
    ProfileDataSourceIndexTweets = 0,
    ProfileDataSourceIndexMedia = 1,
    ProfileDataSourceIndexFavorites = 2
};

@protocol ProfileCellDelegate <NSObject>
- (void)onProfileDataSourceChanged:(ProfileDataSourceIndex)index;
@end


@interface ProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)controlValueChanged:(UISegmentedControl *)sender;
@property (nonatomic, strong) id<ProfileCellDelegate> delegate;
@property (nonatomic, strong) User *user;

@end
