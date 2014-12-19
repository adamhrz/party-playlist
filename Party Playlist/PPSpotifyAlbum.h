//
//  PPSpotifyAlbum.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPAlbum.h"
#import "RZImportable.h"

@interface PPSpotifyAlbum : PPAlbum<RZImportable>

@property (strong, nonatomic) NSString *spotifyAlbumId;

@end
