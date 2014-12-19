//
//  PPSpotifyDAO.h
//  Party Playlist
//
//  Created by Derek Ostrander on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PPSpotifyResponseBlock)(BOOL success, id result, NSError *error);

@interface PPSpotifyDAO : NSObject

- (void) getArtistsTopTracks:(NSString *)artistid completion:(PPSpotifyResponseBlock) completion;
- (void)getCurrentUsersSavedTracks:(PPSpotifyResponseBlock) completion;
- (void)getPlaylist:(NSString *) playlistId forUser:(NSString *) userId completion:(PPSpotifyResponseBlock)completion;

@end
