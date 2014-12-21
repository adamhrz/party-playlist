//
//  ViewController.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Spotify/Spotify.h>

#import "PPPlaylistViewController.h"

#import "PPUser.h"
#import "PPItem.h"
#import "PPTrack.h"
#import "PPSpotifyPlaylist.h"
#import "PPSpotifyArtist.h"
#import "PPPlaylistModel.h"
#import "PPWeightedIndex.h"

#import "PPSpotifyDAO.h"

static NSString* const kPPPlaylistCellIdentifier = @"kPPPlaylistCellIdentifier";

@interface PPPlaylistViewController ()

@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSArray *weightedItems;

@end


@implementation PPPlaylistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // I hate those lines
    self.tableView.tableFooterView = [UIView new];
    
    [[PPUser currentUser] getUsersSpotifyTracks:^(BOOL success, id responseObject, NSError *error) {
        self.tracks = responseObject;
        
        // Ew this needs to be changed, but it works for now
        NSMutableArray *artists = [[NSMutableArray alloc] init];
        for ( SPTTrack *track in self.tracks ) {
            for ( SPTArtist *artist in track.artists ) {
                [artists addObject:[[PPSpotifyArtist alloc] initWithSPTArtist:artist]];
            }
        }
        
        _weightedItems = [PPWeightedIndex rankItemsByCount:[artists valueForKeyPath:@"name"]];
        [self.tableView reloadData];
    }];
}

#pragma mark - Tableview

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weightedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPPPlaylistCellIdentifier];
    NSDictionary *item = self.weightedItems[row];
    NSString *artistName = @"Error";
    NSNumber *weight = @0;
    if ( item.allKeys.count > 0 ) {
        artistName = item.allKeys[0];
        weight = item[artistName];
    }
    cell.textLabel.text = artistName;
    cell.detailTextLabel.text = weight.stringValue;
    return cell;
}

@end
