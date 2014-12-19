//
//  PPTrack.h
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@import Foundation;

@class PPArtist;

@interface PPTrack : NSObject

- (instancetype)initWithArtist:(PPArtist *)artist andTitle:(NSString *)title;

@end
