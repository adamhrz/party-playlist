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
    [sessionService.requestSerializer setValue:@"Bearer BQAm7EMp94iyo2ATMW5Cnl4pCeNwMSyr_-PnBcmQ_oKWOkaCtqA77oJ6dAQRIdOkAfoOo1RvuEbo7hFk6gptcbKPv80zWeJ-cYaGfEODozGbCG05UfQlktdsUovAVZhwLBzWMpN1gc25fMXTjfjNvI-xd6_CuWCj_kTRdUJz0vSWI3eQfiiV2OEfDiTH-4YuJqMJaqKL3y4t8ZfYH3XOTIqBgyIMj3qD4Cie8YCvEx7xgxYzFuTa9db1K3jD1itd4B3R5Oh8XSGwBDQv5Q" forHTTPHeaderField:@"Authorization"];
    return [sessionService GET:path parameters:@{ @"country" : @"SE" } success:success failure:failure];
}

+ (NSURLSessionDataTask *)getCurrentUserSavedTracks:(PPURLSessionSuccessBlock)success failure:(PPURLSessionFailureBlock)failure
{
    PPURLSessionService *sessionService = [[self class] sharedInstance];
    NSString *path = [NSString stringWithFormat:@"https://api.spotify.com/v1/me/tracks"];
        [sessionService.requestSerializer setValue:@"Bearer BQAm7EMp94iyo2ATMW5Cnl4pCeNwMSyr_-PnBcmQ_oKWOkaCtqA77oJ6dAQRIdOkAfoOo1RvuEbo7hFk6gptcbKPv80zWeJ-cYaGfEODozGbCG05UfQlktdsUovAVZhwLBzWMpN1gc25fMXTjfjNvI-xd6_CuWCj_kTRdUJz0vSWI3eQfiiV2OEfDiTH-4YuJqMJaqKL3y4t8ZfYH3XOTIqBgyIMj3qD4Cie8YCvEx7xgxYzFuTa9db1K3jD1itd4B3R5Oh8XSGwBDQv5Q" forHTTPHeaderField:@"Authorization"];
    return [sessionService GET:path parameters:nil success:success failure:failure];

}

+ (NSURLSessionDataTask *)getPlaylist:(NSString *)playlistId forUser:(NSString *) userId success:(PPURLSessionSuccessBlock)success failure:(PPURLSessionFailureBlock)failure
{
    PPURLSessionService *sessionService = [[self class] sharedInstance];
    NSString *path = [NSString stringWithFormat:@"https://api.spotify.com/v1/users/%@/playlists/%@/tracks", userId, playlistId];
    [sessionService.requestSerializer setValue:@"Bearer BQAqVqifQh2jpMwL0Ys43zC_OlEECjkw_3_F_ydB0ha4GebjO7Z1p5OYu5HAHbYpHDx9jtE4fZlP57TBVde1BK_FJUFGU1Z9JctvdlQ7q2d9VT1z6vhIguAOD9RKTrP8yxggRWsifR_HnB9zCZjeO0qNw1I5DPIJfVS-Y2_UnbhyR1NOJdeqgApwe2bgWxVyITCav48OiHtmxfSWSf7AyG9aZK4cKitrLuOSXwQ9uwC5Ue13mlpmcaPo-9-GaC3YeMEe9SQ_TyY2zGo-FA" forHTTPHeaderField:@"Authorization"];
    return [sessionService GET:path parameters:nil success:success failure:failure];
}

@end
