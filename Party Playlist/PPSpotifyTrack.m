//
//  PPSpotifyTrack.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPSpotifyTrack.h"

@implementation PPSpotifyTrack

+ (NSDictionary *)rzi_customMappings
{
    return @{ @"id" : @"spotifyTrackId" };
}

+ (NSArray *)rzi_nestedObjectKeys
{
    return @[ @"artists", @"album" ];
}

@end
