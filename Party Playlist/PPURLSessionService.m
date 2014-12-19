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



@end
