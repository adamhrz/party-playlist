//
//  Party_PlaylistTests.m
//  Party PlaylistTests
//
//  Created by Adam Howitt on 12/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "PPWeightedIndex.h"

@interface Party_PlaylistTests : XCTestCase
@end

@implementation Party_PlaylistTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRankItemsByCount {
    NSArray *testSets = @[
                          @{@"objects":@[@"Adam"],@"result":@[@{@"Adam":[NSNumber numberWithDouble:1.0f]}]},
                          @{@"objects":@[@"Bob",@"Bob",@"Carl",@"Adam",@"Adam",@"Adam"],@"result":@[
                                    @{@"Adam":[NSNumber numberWithDouble:1.0f]},
                                    @{@"Bob":[NSNumber numberWithDouble:2.0/3.0]}
                                    ]},
                          @{@"objects":@[@"Bob",@"Bob",@"Carl",@"Adam",@"Adam",@"Adam",@"Bob",@"Carl",@"Adam"],@"result":@[
                                    @{@"Adam":[NSNumber numberWithDouble:1.0f]},
                                    @{@"Bob":[NSNumber numberWithDouble:3.0/4.0]},
                                    @{@"Carl":[NSNumber numberWithDouble:2.0/4.0]},
                                    ]}

                          ];
    for ( NSDictionary *test in testSets ) {
        NSArray *results = [PPWeightedIndex rankItemsByCount:test[@"objects"]];
        NSArray *expected = test[@"result"];
        for (int i=0; i<results.count; i++) {
            NSDictionary *result = results[i];
            NSDictionary *expectedResult = expected[i];
            XCTAssert([result isEqualToDictionary:expectedResult] && result.count == expectedResult.count);
        }
    }
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
