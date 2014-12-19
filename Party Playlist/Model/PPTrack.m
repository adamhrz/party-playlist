//
//  PPTrack.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPTrack.h"
#import "PPItem.h"

@interface PPTrack ()

@property (strong, nonatomic) PPArtist *artist;
@property (strong, nonatomic) NSString *title;

@end

@implementation PPTrack

- (instancetype)initWithArtist:(PPArtist *)artist andTitle:(NSString *)title
{
    self = [super init];
    if ( self ) {
        self.artist = artist;
        self.title = title;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ by %@",self.title,self.artist.name];
}

@end
