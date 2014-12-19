//
//  PPItem.h
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@import Foundation;

@interface PPItem : NSObject

@property (copy, nonatomic, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

@interface PPArtist : PPItem
@end

@interface PPGenre : PPItem
@end