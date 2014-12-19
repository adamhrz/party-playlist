//
//  PPSpotifyArtist.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPItem.h"
#import "NSObject+RZImport.h"

@interface PPSpotifyArtist : PPArtist<RZImportable>

@property (strong, nonatomic) NSString *spotifyArtistId;

@end
