//
//  GHTestSkip.m
//  GHUnit
//
//  Created by Gabriel Handford on 7/15/09.
//  Copyright 2009. All rights reserved.
//

#import "GHTestCase.h"

@interface GHTestSkip : GHTestCase { }
@end

@implementation GHTestSkip

- (void)testFail_SKIPPED {
  GHSkip();
}

- (void)testSucceedAfterSkip {
}

@end
