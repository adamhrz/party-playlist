//
//  PPSpotifyTrack.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPTrack.h"
#import "NSObject+RZImport.h"

@class PPAlbum;
@interface PPSpotifyTrack : PPTrack<RZImportable>

@property (strong, nonatomic) NSString *spotifyTrackId;
@property (strong, nonatomic) NSString *href;
@property (strong, nonatomic) NSString *imageHref;
@property (strong, nonatomic) NSArray *artists;
@property (strong, nonatomic) PPAlbum *album;

@end
