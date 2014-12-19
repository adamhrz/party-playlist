//
//  PPWeightedIndex.m
//  Party Playlist
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "PPWeightedIndex.h"

@implementation PPWeightedIndex
+ (NSArray *)rankItemsByCount:(NSArray *)items
{
    NSMutableDictionary *countingDictionary = [NSMutableDictionary dictionary];
    for (NSString *item in items) {
        NSNumber *currentValue = [countingDictionary objectForKey:item];
        if ( currentValue != nil ) {
            [countingDictionary setValue:@([currentValue intValue]+1) forKey:item];
        }
        else {
            [countingDictionary setValue:@(1) forKey:item];
        }
    }
    
    NSArray *itemsDescendingByCount  = [countingDictionary keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *itemsWithCount = [NSMutableArray array];
    double maxValue = [countingDictionary[itemsDescendingByCount[0]] doubleValue];
    for (NSString *item in itemsDescendingByCount) {
        double itemValue = [countingDictionary[item] doubleValue];
        if ( itemValue > 1.0f ) {
            [itemsWithCount addObject:@{item:@(itemValue/maxValue)}];
        }
    }
    NSLog(@"%@",[itemsWithCount description]);
    return itemsWithCount;
}

+ (NSArray *)rankItemsByCount:(NSArray *)items atObjectKeyPath:(NSString *)keypath
{
    return nil;
}

+ (NSArray *)rankItemsBySummation:(NSArray *)items atObjectKeyPath:(NSString *)keypath
{
    return nil;
}

@end
