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
    if ( [key isEqualToString:@"items"] ) {
        _tracks = [PPSpotifyTrack rzi_objectsFromArray:[value valueForKey:@"track"]];
        NSLog(@"%@",[value valueForKey:@"track"]);
        _artistNames = [NSMutableArray new];
        for (NSDictionary *dic in [value valueForKey:@"track"]) {
            NSArray *artists = dic[@"artists"];
            if ( artists.count > 0 ){
                [_artistNames addObject:artists[0][@"name"] ];
            }
        }

        return NO;
    }
    return YES;
}

@end
