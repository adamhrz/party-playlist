//
//  PPSpotifyDAO.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Spotify/Spotify.h>
#import <JLRoutes.h>

#import "PPSpotifyDAO.h"
#import "PPURLSessionService.h"

#import "PPItem.h"
#import "PPSpotifyTrack.h"
#import "PPSpotifyPlaylist.h"

#import "NSObject+RZImport.h"
#import "RZDispatch.h"

static NSString *const kPPSpotifyClientId = @"8d63b1aac37b447baa46076140ec16df";
static NSString *const kPPSpotifyClientSecret = @"eb3f68ca5f3243c9a764c017ae99a9d9";
static NSString *const kPPSpotifyCallbackUrl = @"partyplaylist://loggedIn";
static NSString *const kPPSpotifyTokenSwapUrl = @"https://party-playlist.herokuapp.com/swap";

@interface PPSpotifyDAO ()

@property (strong, nonatomic) SPTSession *session;

@end

@implementation PPSpotifyDAO

+ (NSURL *)loginUrl
{
    return [[SPTAuth defaultInstance] loginURLForClientId:kPPSpotifyClientId
                                      declaredRedirectURL:[NSURL URLWithString:kPPSpotifyCallbackUrl]
                                                   scopes:@[ SPTAuthUserReadPrivateScope, SPTAuthUserLibraryReadScope ]];
}

#pragma mark - Authentication

- (void)loginToSpotify
{
    UIApplication *application = [UIApplication sharedApplication];
    [application performSelector:@selector(openURL:)
                      withObject:[[self class] loginUrl]
                      afterDelay:.1];
}

- (void)handleSpotifyAuthenticated:(NSDictionary *)parameters callback:(PPSpotifyResponseBlock)callback
{
    NSURL *url = parameters[kJLRouteURLKey];
    
    if ( [[SPTAuth defaultInstance] canHandleURL:url withDeclaredRedirectURL:[NSURL URLWithString:kPPSpotifyCallbackUrl]] ) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url
                                            tokenSwapServiceEndpointAtURL:[NSURL URLWithString:kPPSpotifyTokenSwapUrl]
                                                                 callback:^(NSError *error, SPTSession *session) {
                                                                     if ( !error ) {
                                                                         _session = session;
                                                                     } else {
                                                                         NSLog(@"%@",error);
                                                                         [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
                                                                     }
                                                                     if ( callback ) {
                                                                         callback((error == nil), nil, error);
                                                                     }
                                                                 }];
    }
}

#pragma mark - Fetches

- (void)getAllTracksForCurrentUser:(PPSpotifyResponseBlock)callback
{
    [SPTRequest savedTracksForUserInSession:self.session callback:^(NSError *error, id object) {
        __block SPTListPage *totalListPage = object;
        NSUInteger totalListLength = totalListPage.totalListLength;
        __block NSError *spotifyError = nil;
        __block BOOL nextPageSet = NO;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            while ( totalListPage.range.location+totalListPage.range.length < totalListLength ) {
                nextPageSet = NO;
                
                [totalListPage requestNextPageWithSession:self.session callback:^(NSError *error, id object) {
                    NSLog(@"%@",totalListPage);
                    if (!error ) {
                        totalListPage = [totalListPage pageByAppendingPage:object];
                        nextPageSet = YES;
                    } else {
                        spotifyError = error;
                    }
                }];
                
                while ( !nextPageSet ) {
                    sleep(.5);
                    if ( spotifyError ){
                        break;
                    }
                }
            }
            
            rz_dispatch_main_reentrant(^{
                
                @synchronized(totalListPage){
                    callback(spotifyError == nil, totalListPage, spotifyError);
                }
            });
        });
    }];
}
//126482211
- (void)getPlaylist:(NSString *) playlistId forUser:(NSString *) userId completion:(PPSpotifyResponseBlock)completion
{
    [PPURLSessionService getPlaylist:playlistId forUser:userId success:^(NSURLSessionDataTask *task, id responseObject) {
        PPSpotifyPlaylist *playlist = [PPSpotifyPlaylist rzi_objectFromDictionary:responseObject];
        if ( completion )
            completion(YES, playlist, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ( completion ) {
            completion(NO, nil, error);
        }
    }];
}
- (void)getCurrentUsersSavedTracks:(PPSpotifyResponseBlock) completion{
    [PPURLSessionService getCurrentUserSavedTracks:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
