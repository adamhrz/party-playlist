//
//  PPURLSessionService.m
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPURLSessionService.h"

@implementation PPURLSessionService

+ (PPURLSessionService *)sharedInstance
{
    static PPURLSessionService *s = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        s = [[PPURLSessionService alloc] init];
    });
    
    return s;
}

+ (NSURLSessionDataTask *)getTopTracksFromArtist:(NSString *)artistId success:(PPURLSessionSuccessBlock)success failure:(PPURLSessionFailureBlock)failure
{
    PPURLSessionService *sessionService = [[self class] sharedInstance];
    NSString *path = [NSString stringWithFormat:@"https://api.spotify.com/v1/artists/%@/top-tracks", artistId];
    return [sessionService GET:path parameters:@{ @"country" : @"SE" } success:success failure:failure];
}

@end
