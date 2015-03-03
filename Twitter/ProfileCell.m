//
//  ProfileCell.m
//  Twitter
//
//  Created by Thuy Nguyen on 3/1/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(User *)user {
    _user = user;
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    
    self.followersLabel.text = [NSString stringWithFormat:@"%ld", self.user.followersCount];
    self.followingLabel.text = [NSString stringWithFormat:@"%ld", self.user.followingCount];
    //UIImageView *bannerView = [[UIImageView alloc] init];
    //[self.bannerView setImageWithURL:[NSURL URLWithString:self.user.profileBannerUrl]];
    //self.bannerView = bannerView;
}

- (IBAction)controlValueChanged:(UISegmentedControl *)sender {
    [self.delegate onProfileDataSourceChanged:sender.selectedSegmentIndex];
}
@end
