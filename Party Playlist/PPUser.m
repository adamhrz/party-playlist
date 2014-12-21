//
//  PPUser.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/21/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Spotify/Spotify.h>

#import "PPUser.h"
#import "PPSpotifyDAO.h"


//typedef BOOL (BOOL (^)(NSDictionary *parameters)) ;

@interface PPUser ()

@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) PPSpotifyDAO *spotifyDAO;

@end

@implementation PPUser

- (void)commonInit
{
    _tracks = @[];
    _spotifyDAO = [[PPSpotifyDAO alloc] init];
}
- (id) init
{
    if ( self  = [super init] ) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initPrivate
{
    if ( self = [self init] ) {
        [self commonInit];
    }
    return self;
}

+ (PPUser *) currentUser
{
    static PPUser *currentUser = nil;
    
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        currentUser = [[[self class ] alloc] initPrivate];
    });
    return currentUser;
}

- (void) loginToSpotify
{
    [self.spotifyDAO loginToSpotify];
}

- (void)handleSpotifyAuthenticated:(NSDictionary *)parameters callback:(kPPUserFetchCallback)callback
{
    [self.spotifyDAO handleSpotifyAuthenticated:parameters callback:callback];
}

- (NSArray *)getUsersSpotifyTracks:(kPPUserFetchCallback)callback
{
    [self.spotifyDAO getAllTracksForCurrentUser:^(BOOL success, id result, NSError *error) {
        SPTListPage *listPage = result;
        _tracks = listPage.items;
        if ( callback ) {
            callback(success, _tracks, error);
        }
    }];
    return self.tracks;
}


@end
