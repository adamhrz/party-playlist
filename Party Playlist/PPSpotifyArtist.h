//
//  PPSpotifyArtist.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPItem.h"
#import "PPArtist.h"

@class SPTArtist;
@interface PPSpotifyArtist : PPArtist

- (id) initWithSPTArtist:(SPTArtist *)artist;

@end
