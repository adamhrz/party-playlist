//
//  PPUser.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/21/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^kPPUserFetchCallback)(BOOL success, id responseObject, NSError *error);

@interface PPUser : NSObject

+ (PPUser *)currentUser;
- (void)loginToSpotify;
- (void)handleSpotifyAuthenticated:(NSDictionary *)parameters callback:(kPPUserFetchCallback)callback;
- (NSArray *)getUsersSpotifyTracks:(kPPUserFetchCallback)callback;

@end
