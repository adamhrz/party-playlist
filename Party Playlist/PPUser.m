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
static NSString* const kPPSpotifySessionUsernameKey = @"kPPSpotifySessionUsernameKey";
static NSString* const kPPSpotifySessionAccessTokenKey = @"kPPSpotifySessionAccessTokenKey";
static NSString* const kPPSpotifySessionExpirationDateKey = @"kPPSpotifySessionExpirationDateKey";
//static NSString* const kPPSpotifySessionKey = @"kPPSpotifySessionUsernameKey";

@interface PPUser ()

@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) PPSpotifyDAO *spotifyDAO;

@end

@implementation PPUser

+ (PPUser *) currentUser
{
    static PPUser *currentUser = nil;
    
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        currentUser = [[[self class ] alloc] initPrivate];
    });
    return currentUser;
}

// quick and dirty session persistance

+ (BOOL)hasSpotifySession
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:kPPSpotifySessionUsernameKey];
    NSString *accessToken = [userDefaults objectForKey:kPPSpotifySessionAccessTokenKey];
    NSDate *expirationDate = [userDefaults objectForKey:kPPSpotifySessionExpirationDateKey];
    return accessToken != nil;
}

+ (SPTSession *)savedSpotifySession
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:kPPSpotifySessionUsernameKey];
    NSString *accessToken = [userDefaults objectForKey:kPPSpotifySessionAccessTokenKey];
    NSDate *expirationDate = [userDefaults objectForKey:kPPSpotifySessionExpirationDateKey];
    SPTSession *session = [[SPTSession alloc] initWithUserName:username accessToken:accessToken expirationDate:expirationDate];
    return session;
}

+ (void)saveSpotifySession:(SPTSession *)session
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:session.accessToken forKey:kPPSpotifySessionAccessTokenKey];
    [defaults setObject:session.canonicalUsername forKey:kPPSpotifySessionUsernameKey];
    [defaults setObject:session.expirationDate forKey:kPPSpotifySessionExpirationDateKey];
    [defaults synchronize];
}

+ (void)deleteSpotifySession:(SPTSession *)session
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kPPSpotifySessionAccessTokenKey];
    [defaults removeObjectForKey:kPPSpotifySessionUsernameKey];
    [defaults removeObjectForKey:kPPSpotifySessionExpirationDateKey];
    [defaults synchronize];
}

#pragma mark - Init

- (id)init
{
    if ( self  = [super init] ) {
        [self commonInit];
    }
    return self;
}

- (id)initPrivate
{
    if ( self = [self init] ) {

        if ( [[self class] hasSpotifySession] ) {
            _spotifyDAO = [[PPSpotifyDAO alloc] initWithSession:[[self class] savedSpotifySession]];
        }
    }
    return self;
}

- (void)commonInit
{
    _tracks = @[];
    _spotifyDAO = [[PPSpotifyDAO alloc] init];
}


#pragma mark - Spotify Authentication

- (void) loginToSpotify
{
    [self.spotifyDAO loginToSpotify];
}

- (void)handleSpotifyAuthenticated:(NSDictionary *)parameters callback:(kPPUserFetchCallback)callback
{
    [self.spotifyDAO handleSpotifyAuthenticated:parameters callback:^(BOOL success, id result, NSError *error) {
        if ( success ) {
            [[self class] saveSpotifySession:result];
        }
        
        callback(success, nil, error);
    }];
}

#pragma mark - Spotify Fetching

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
