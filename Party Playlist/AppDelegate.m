//
//  AppDelegate.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "AppDelegate.h"
#import "PPPlaylistModel.h"

// The Bonjour service type consists of an IANA service name (see RFC 6335)
// prefixed by an underscore (as per RFC 2782).
//
// <http://www.ietf.org/rfc/rfc6335.txt>
//
// <http://www.ietf.org/rfc/rfc2782.txt>
//
// See Section 5.1 of RFC 6335 for the specifics requirements.
//
// To avoid conflicts, you must register your service type with IANA before
// shipping.
//
// To help network administrators indentify your service, you should choose a
// service name that's reasonably human readable.

static NSString * kWiTapBonjourType = @"_partyplaylist1._tcp.";

@interface AppDelegate () <NSNetServiceDelegate,
NSStreamDelegate>

@property (nonatomic, strong, readwrite) NSNetService *server;
@property (nonatomic, assign, readwrite) BOOL                   isServerStarted;
@property (nonatomic, copy,   readwrite) NSString *             registeredName;
@property (nonatomic, strong, readwrite) NSInputStream *        inputStream;
@property (nonatomic, strong, readwrite) NSOutputStream *       outputStream;
@property (nonatomic, assign, readwrite) NSUInteger             streamOpenCount;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.server = [[NSNetService alloc] initWithDomain:@"local." type:kWiTapBonjourType name:[UIDevice currentDevice].name port:0];
    self.server.includesPeerToPeer = YES;
    [self.server setDelegate:self];
    [self.server publishWithOptions:NSNetServiceListenForConnections];
    self.isServerStarted = YES;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
#pragma unused(application)
    
    // If there's a game playing, shut it down.  Whether this is the right thing to do
    // depends on your app.  In some cases it might be more sensible to leave the connection
    // in place for a short while to see if the user comes back to the app.  This issue is
    // discussed in more depth in Technote 2277 "Networking and Multitasking".
    //
    // <https://developer.apple.com/library/ios/#technotes/tn2277/_index.html>
    
    if (self.inputStream) {
//        [self setupForNewGame];
    }
    
    // Quiesce the server and service browser, if any.
    
    [self.server stop];
    self.isServerStarted = NO;
    self.registeredName = nil;
//    if (self.picker != nil) {
//        [self.picker stop];
//    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#pragma unused(application)
    
    // Quicken the server.  Once this is done it will quicken the picker, if there's one up.
    
    assert( ! self.isServerStarted );
    [self.server publishWithOptions:NSNetServiceListenForConnections];
    self.isServerStarted = YES;
    if (self.registeredName != nil) {
//        [self startPicker];
    }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
