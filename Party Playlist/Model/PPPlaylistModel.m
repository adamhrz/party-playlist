//
//  PPPlaylistModel.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPPlaylistModel.h"

@interface PPPlaylistModel ()

@property (strong, nonatomic, readwrite) NSMutableArray *playlist;
@property (assign, nonatomic, readwrite) int currentTrackIndex;

@end

@implementation PPPlaylistModel

+ (instancetype)sharedInstance
{
    static PPPlaylistModel *s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[PPPlaylistModel alloc] initWithItems:@[]];
    });
    return s_manager;
}

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if ( self ) {
        self.playlist = [items mutableCopy];
        self.currentTrackIndex = 0;
    }
    return self;
}

- (PPTrack *)nowPlaying
{
    return [self.playlist objectAtIndex:self.currentTrackIndex];
}

- (PPTrack *)trackAtIndex:(int)index
{
    return [self.playlist objectAtIndex:index];
}

- (void)addTracks:(NSArray *)tracks
{
    [self.playlist addObjectsFromArray:tracks];
}

@end
