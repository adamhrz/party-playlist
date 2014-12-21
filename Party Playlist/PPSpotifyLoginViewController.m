//
//  PPSpotifyLoginViewController.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/21/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPSpotifyLoginViewController.h"

#import "PPUser.h"

NSString* const kPPUserAuthenticatedSegueIdentifier = @"kPPUserAuthenticatedSegueIdentifier";

@interface PPSpotifyLoginViewController ()

@end

@implementation PPSpotifyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( [PPUser hasSpotifySession] ) {
        [self performSegueWithIdentifier:kPPUserAuthenticatedSegueIdentifier sender:nil];
    }
}

- (IBAction)loginToSpotifyTapped:(id)sender {
    [[PPUser currentUser] loginToSpotify];
}

@end
