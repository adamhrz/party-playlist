//
//  PPSpotifyDAO.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PPSpotifyResponseBlock)(BOOL success, id result, NSError *error);

@interface PPSpotifyDAO : NSObject

- (id)initWithSession:(SPTSession *)session;
- (void)loginToSpotify;
- (void)handleSpotifyAuthenticated:(NSDictionary *)parameters callback:(PPSpotifyResponseBlock)callback;
- (void)getAllTracksForCurrentUser:(PPSpotifyResponseBlock)callback;

@end
