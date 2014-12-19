//
//  ViewController.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "ViewController.h"

#import "PPPlaylistModel.h"
#import "PPTrack.h"
#import "PPItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PPPlaylistModel *playlist = [PPPlaylistModel sharedInstance];
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
