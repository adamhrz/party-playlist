//
//  PPItem.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPItem.h"

@interface PPItem ()
@property (copy, nonatomic) NSString *name;
@end

@implementation PPItem

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if ( self ) {
        self.name = name;
    }
    return self;
}

@end

@implementation PPGenre
@end

@implementation PPArtist
@end

@implementation PPTrack
@end

