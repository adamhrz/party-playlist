//
//  PPSpotifyArtist.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Spotify/Spotify.h>
#import "PPSpotifyArtist.h"

@implementation PPSpotifyArtist

- (id) initWithSPTArtist:(SPTArtist *)artist
{
    if ( self = [super initWithIdentifier:artist.identifier name:artist.name] ) {
        
    }
    return self;
}

@end
