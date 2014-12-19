//
//  ViewController.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPPlaylistViewController.h"

#import "PPPlaylistModel.h"
#import "PPTrack.h"
#import "PPItem.h"

#import "PPSpotifyDAO.h"

@interface PPPlaylistViewController ()

@end

@implementation PPPlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PPPlaylistModel *playlist = [PPPlaylistModel sharedInstance];
    NSString *artistId = @"5iKTnjAstcWhyW5CSyuogv";
    NSArray *tracks = @[
                        @{@"artist":@"Frank Sinatra",@"title":@"My Way"},
                        @{@"artist":@"Frank Sinatra",@"title":@"The First Noel"}
                        ];
    
    NSMutableArray *playlistTracks = [NSMutableArray array];
    
    for (NSDictionary *track in tracks) {
        PPArtist *artist = [[PPArtist alloc] initWithName:track[@"artist"]];
        PPTrack *currentTrack = [[PPTrack alloc] initWithArtist:artist andTitle:track[@"title"]];
        [playlistTracks addObject:currentTrack];
    }
    [playlist addTracks:playlistTracks];
    NSLog(@"Now playing: %@",[playlist nowPlaying]);
    
    
    PPSpotifyDAO *spotifyDao = [PPSpotifyDAO new];
    
    [spotifyDao getArtistsTopTracks:artistId completion:^(BOOL success, id result, NSError *error) {
        
    }];
}

@end
