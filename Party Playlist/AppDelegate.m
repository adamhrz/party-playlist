//
//  AppDelegate.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <JLRoutes.h>
#import "AppDelegate.h"
#import "PPSpotifyLoginViewController.h"
#import "PPUser.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [JLRoutes addRoute:@"/loggedIn" handler:^BOOL(NSDictionary *parameters) {
        [[PPUser currentUser] handleSpotifyAuthenticated:parameters callback:^(BOOL success, id responseObject, NSError *error) {
            if ( success ) {
                id navigationController = self.window.rootViewController;
                [[navigationController topViewController] performSegueWithIdentifier:kPPUserAuthenticatedSegueIdentifier sender:nil];
            }
        }];
        return YES;
    }];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [JLRoutes routeURL:url];
}

@end
