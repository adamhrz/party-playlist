//
//  PPWeightedIndex.h
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPWeightedIndex : NSObject

+ (NSArray *)rankItemsByCount:(NSArray *)items;
+ (NSArray *)rankItemsByCount:(NSArray *)items atObjectKeyPath:(NSString *)keypath;
+ (NSArray *)rankItemsBySummation:(NSArray *)items atObjectKeyPath:(NSString *)keypath;

@end
