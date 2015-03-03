//
//  User.h
//  Twitter
//
//  Created by Baeksan Oh on 2/22/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *profileBannerUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, assign) NSInteger followersCount;
@property (nonatomic, assign) NSInteger followingCount;
@property (nonatomic, assign) NSInteger favoritesCount;
@property (nonatomic, strong) NSString *userId;
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (User *)user;
+ (void)setUser:(User *)user;
+ (void)logout;
@end
