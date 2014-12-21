//
//  PPUser.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/21/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^kPPUserFetchCallback)(BOOL success, id responseObject, NSError *error);

@class SPTSession;
@interface PPUser : NSObject

+ (PPUser *)currentUser;

// spotify quick and dirty session mgmt
+ (BOOL)hasSpotifySession;
+ (SPTSession *)savedSpotifySession;
+ (void)saveSpotifySession:(SPTSession *)session;
+ (void)deleteSpotifySession:(SPTSession *)session;

// spotify auth
- (void)loginToSpotify;
- (void)handleSpotifyAuthenticated:(NSDictionary *)parameters callback:(kPPUserFetchCallback)callback;

// spotify fetches
- (NSArray *)getUsersSpotifyTracks:(kPPUserFetchCallback)callback;

@end
