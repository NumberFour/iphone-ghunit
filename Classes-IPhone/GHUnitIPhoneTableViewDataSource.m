//
//  GHUnitIPhoneTableViewDataSource.m
//  GHUnitIPhone
//
//  Created by Gabriel Handford on 5/5/09.
//  Copyright 2009. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "GHUnitIPhoneTableViewDataSource.h"

@implementation GHUnitIPhoneTableViewDataSource

- (GHTestNode *)nodeForIndexPath:(NSIndexPath *)indexPath {
  GHTestNode *sectionNode = self.topLevel ? [[[self root] children] objectAtIndex:indexPath.section] : self.root;
  return [[sectionNode children] objectAtIndex:indexPath.row];
}

- (void)setSelectedForAllNodes:(BOOL)selected {
  for(GHTestNode *sectionNode in [[self root] children]) {
    for(GHTestNode *node in [sectionNode children]) {
      [node setSelected:selected];
    }
  }
}

#pragma mark Data Source (UITableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSInteger numberOfSections = [self numberOfGroups];
  if (numberOfSections > 0) return numberOfSections;
  return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
  return [self numberOfTestsInGroup:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (!self.topLevel) {
    return [self root].name;
  }
	
  NSArray *children = [[self root] children];
  if ([children count] == 0) return nil;
  GHTestNode *sectionNode = [children objectAtIndex:section];
  return sectionNode.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  GHTestNode *sectionNode = self.topLevel ? [[[self root] children] objectAtIndex:indexPath.section] : self.root;
  GHTestNode *node = [[sectionNode children] objectAtIndex:indexPath.row];
  
  static NSString *CellIdentifier = @"ReviewFeedViewItem";  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (!cell)
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];   
  
  if (editing_) {
    cell.textLabel.text = node.name;
  } else {
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", node.name, node.statusString];
  }

  cell.textLabel.textColor = [UIColor lightGrayColor];
  cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
  
  if (editing_) {
    if (node.isSelected) cell.textLabel.textColor = [UIColor blackColor];
  } else {
    if ([node status] == GHTestStatusRunning) {
      cell.textLabel.textColor = [UIColor blackColor];
    } else if ([node status] == GHTestStatusErrored) {
      cell.textLabel.textColor = [UIColor redColor];
    } else if ([node status] == GHTestStatusSucceeded) {
      cell.textLabel.textColor = [UIColor blackColor];
    } else if ([node status] == GHTestStatusSkipped) {
		cell.textLabel.textColor = [UIColor darkGrayColor];
    } else if (node.isSelected) {
      if (node.isSelected) cell.textLabel.textColor = [UIColor darkGrayColor];
    }
  }
  
  UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
  if (self.isEditing && node.isSelected) accessoryType = UITableViewCellAccessoryCheckmark;
  else if (node.isEnded) accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
  cell.accessoryType = accessoryType; 
  
  return cell;  
}

@end
