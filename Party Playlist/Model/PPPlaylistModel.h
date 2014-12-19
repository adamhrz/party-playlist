//
//  PPPlaylistModel.h
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPTrack;

@interface PPPlaylistModel : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *playlist;
@property (assign, nonatomic, readonly) int currentTrackIndex;

+ (instancetype)sharedInstance;

- (PPTrack *)nowPlaying;
- (PPTrack *)trackAtIndex:(int)index;
- (void)addTracks:(NSArray *)tracks;
@end
