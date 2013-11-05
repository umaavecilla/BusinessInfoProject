//
//  BusinessTableCell.h
//  BusinessInfo
//
//  Created by Apple Macintosh on 11/5/13.
//  Copyright (c) 2013 Apple Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblCategory;

@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (weak, nonatomic) IBOutlet UILabel *lblContactNo;


@end
