//
//  GHUnitIPhoneView.m
//  GHUnitIPhone
//
//  Created by Gabriel Handford on 4/12/10.
//  Copyright 2010. All rights reserved.
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

#import "GHUnitIPhoneView.h"

@implementation GHUnitIPhoneView

@synthesize statusLabel=statusLabel_, filterControl=filterControl_, tableView=tableView_, topLevel=topLevel_;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | 
      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;

    // Table view
    tableView_ = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView_.sectionIndexMinimumDisplayRowCount = 5;
    [self addSubview:tableView_];
    [tableView_ release];
	  
	if (topLevel_) {
		footerView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 36)];
		footerView_.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
		
		// Status label
		statusLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 36)];
		statusLabel_.text = @"Select 'Run' to start tests";
		statusLabel_.backgroundColor = [UIColor clearColor];
		statusLabel_.font = [UIFont systemFontOfSize:12];
		statusLabel_.numberOfLines = 2;
		statusLabel_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[footerView_ addSubview:statusLabel_];
		[statusLabel_ release];

		[self addSubview:footerView_];
		[footerView_ release];
	}
    
    runToolbar_ = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 36)];
    filterControl_ = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Failed", nil]];
    filterControl_.frame = CGRectMake(20, 6, 280, 24);
    filterControl_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    filterControl_.segmentedControlStyle = UISegmentedControlStyleBar;
    [runToolbar_ addSubview:filterControl_];
    [filterControl_ release];
    [self addSubview:runToolbar_];
    [runToolbar_ release];    
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGSize size = self.frame.size;
  CGFloat y = 0;  
  CGFloat contentHeight = size.height - 36;
  
  if (footerView_) {
	  contentHeight -= 36;
  }
	
  tableView_.frame = CGRectMake(0, y, size.width, contentHeight);
  y += contentHeight;

  if (footerView_) {
	  footerView_.frame = CGRectMake(0, y, size.width, 36);
	  y += 36;
  }
  
  runToolbar_.frame = CGRectMake(0, y, size.width, 36);      
}

@end
