//
//  ViewController.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPPlaylistViewController.h"


#import "PPUser.h"
#import "PPPlaylistModel.h"
#import "PPTrack.h"
#import "PPItem.h"
#import "PPSpotifyPlaylist.h"
#import "PPWeightedIndex.h"

#import "PPSpotifyDAO.h"

@interface PPPlaylistViewController ()

@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSArray *weightedItems;

@end


@implementation PPPlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PPUser currentUser] getUsersSpotifyTracks:^(BOOL success, id responseObject, NSError *error) {
        
    }];
    
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
    
//    [spotifyDao getPlaylist:@"1AmGw8xEuchjKdZKKUH0Ny" forUser:@"126482211" completion:^(BOOL success, id result, NSError *error) {
//        PPSpotifyPlaylist *playlist = (PPSpotifyPlaylist *) result;
//        NSLog(@"%@",playlist.artistNames);
//        _weightedItems = [PPWeightedIndex rankItemsByCount:playlist.artistNames];
//    }];
}

@end
