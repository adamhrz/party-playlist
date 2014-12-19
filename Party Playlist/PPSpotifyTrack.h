//
//  PPSpotifyTrack.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPTrack.h"

@interface PPSpotifyTrack : PPTrack

@property (strong, nonatomic) NSString *spotifyTrackId;
@property (strong, nonatomic) NSString *href;
@property (strong, nonatomic) NSString *imageHref;


@end
