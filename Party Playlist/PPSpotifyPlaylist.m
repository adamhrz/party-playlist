//
//  PPSpotifyPlaylist.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPSpotifyPlaylist.h"
#import "PPSpotifyTrack.h"

@implementation PPSpotifyPlaylist

+ (NSDictionary *) rzi_customMappings
{
    return @{ @"id" : @"spotifyPlaylistId" };
}

+ (NSArray *)rzi_nestedObjectKeys
{
    return @[ @"items" ];
}

//+ (BOOL) rzi
- (BOOL)rzi_shouldImportValue:(id)value forKey:(NSString *)key
{
    if ( [key isEqualToString:@"tracks"] ) {
        _tracks = [PPSpotifyTrack rzi_objectsFromArray:[value valueForKey:@"track"]];
        return NO;
    }
    return YES;
}

@end
