//
//  PPSpotifyDAO.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Spotify/Spotify.h>
#import "PPSpotifyDAO.h"
#import "PPURLSessionService.h"

#import "PPItem.h"
#import "PPSpotifyTrack.h"

#import "NSObject+RZImport.h"

static NSString *const kPPSpotifyClientId = @"2b8f2b6f3b8f4e93b51e91eb642db48b";
static NSString *const kPPSpotifyClientSecret = @"87d5fa8eb9344cfda35a049c7d3a2046";
static NSString *const kPPSpotifyCallbackUrl = @"";
//static NSString const* kPPSpotifyTokenSwapServiceURL = @"";

@implementation PPSpotifyDAO

+ (NSURL *) loginUrl
{
    return [[SPTAuth defaultInstance] loginURLForClientId:kPPSpotifyClientId declaredRedirectURL:[NSURL URLWithString:kPPSpotifyCallbackUrl]];
}

+ (NSDictionary *)rzi_customKeyMappings
{
    return @{
             @"id" : @"spotifyTrackId"
             };
}


- (void) getArtistsTopTracks:(NSString *)artistid completion:(PPSpotifyResponseBlock) completion
{
    [PPURLSessionService getTopTracksFromArtist:artistid success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *topTracks = [PPSpotifyTrack rzi_objectsFromArray:responseObject[@"tracks"]];
        if ( completion ) {
            completion(YES, topTracks, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ( completion ) {
            completion(NO, nil, error);
        }
    }];
}

@end
