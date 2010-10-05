//
//  GHIPhoneUIChanges.m
//  GHUnitIPhone
//
//  Created by Wolfgang Knebel on 9/24/10.
//  Copyright 2010 NumberFour AG. All rights reserved.
//

#import "GHIPhoneUIChanges.h"

@implementation GHIPhoneUIChanges

+ (GHTestGroup*) testGroup {
	GHTestGroup* group = [[[GHTestGroup alloc] initWithName:@"TestGroup" delegate:nil] autorelease];

	GHTestGroup* subGroup = [[[GHTestGroup alloc] initWithName:@"SubGroup" delegate:nil] autorelease];

	Class class1 = objc_getClass("GHTestFail");
	id testCase1 = [[[class1 alloc] init] autorelease];
	GHTestGroup* test1 = [[GHTestGroup alloc] initWithTestCase:testCase1 delegate:nil];
	[subGroup addTestGroup:test1];

	Class class2 = objc_getClass("GHTestOnMainThread");
	id testCase2 = [[[class2 alloc] init] autorelease];
	GHTestGroup* test2 = [[GHTestGroup alloc] initWithTestCase:testCase2 delegate:nil];
	[subGroup addTestGroup:test2];

	Class class3 = objc_getClass("GHAsyncTestCaseTest");
	id testCase3 = [[[class3 alloc] init] autorelease];
	GHTestGroup* test3 = [[GHTestGroup alloc] initWithTestCase:testCase3 delegate:nil];
	[subGroup addTestGroup:test3];

	[group addTestGroup:subGroup];

	return group;
}

@end
