//
//  PPSpotifyArtist.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPSpotifyArtist.h"
#import "NSObject+RZImport.h"

@implementation PPSpotifyArtist

+ (NSDictionary *) rzi_customMappings
{
    return @{ @"id" : @"spotifyArtistId" };
}

@end
