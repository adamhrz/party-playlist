//
//  PPSpotifyPlaylist.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPPlaylistModel.h"

@interface PPSpotifyPlaylist : PPPlaylistModel

@property (strong, nonatomic) NSString *spotifyPlaylistId;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSMutableArray *artistNames;

@end
