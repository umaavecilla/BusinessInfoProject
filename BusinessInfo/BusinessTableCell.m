//
//  BusinessTableCell.m
//  BusinessInfo
//
//  Created by Apple Macintosh on 11/5/13.
//  Copyright (c) 2013 Apple Macintosh. All rights reserved.
//

#import "BusinessTableCell.h"

@implementation BusinessTableCell
@synthesize lblName=_lblName;
@synthesize lblCategory=_lblCategory;
@synthesize lblLocation=_lblLocation;
@synthesize lblContactNo = _lblContactNo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
