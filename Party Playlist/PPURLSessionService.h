//
//  PPURLSessionService.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^PPURLSessionSuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^PPURLSessionFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface PPURLSessionService : AFHTTPSessionManager

+ (PPURLSessionService *) sharedInstance;
+ (NSURLSessionDataTask *)getTopTracksFromArtist:(NSString *)artistId success:(PPURLSessionSuccessBlock)success failure:(PPURLSessionFailureBlock)failure;
+ (NSURLSessionDataTask *)getCurrentUserSavedTracks:(PPURLSessionSuccessBlock)success failure:(PPURLSessionFailureBlock)failure;
+ (NSURLSessionDataTask *)getPlaylist:(NSString *)playlistId forUser:(NSString *) userId success:(PPURLSessionSuccessBlock)success failure:(PPURLSessionFailureBlock)failure;

@end
