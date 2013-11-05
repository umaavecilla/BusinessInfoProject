//
//  BussInfoViewController.h
//  BusinessInfo
//
//  Created by Apple Macintosh on 11/4/13.
//  Copyright (c) 2013 Apple Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "BusinessTableCell.h"
#import <CoreLocation/CoreLocation.h>


@interface BussInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *mapView;

@property (weak, nonatomic) IBOutlet UITableView *tblBusiness;
@property(nonatomic,retain) CLLocationManager *locationManager;


-(NSMutableArray*)getBusinessInfo:(NSURL *)url;


@end
