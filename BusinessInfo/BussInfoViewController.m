//
//  BussInfoViewController.m
//  BusinessInfo
//
//  Created by Apple Macintosh on 11/4/13.
//  Copyright (c) 2013 Apple Macintosh. All rights reserved.
//

#import "BussInfoViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GoogleMaps/GMSCameraPosition.h>

@interface BussInfoViewController (){

    NSArray *BusinessInfo;
    NSArray *BusinessInfoName;
    NSArray *BusinessInfoLocation;
    NSArray *BusinessInfoCategory;
    NSArray *BusinessInfoContact;
    NSArray *BusinessLat;
    NSArray *BusinessLong;
    NSArray *BusinessCity;
    NSArray *BusinessState;
    
    GMSMapView *mapView_;
    UIAlertView *alert;
    
}

@end

@implementation BussInfoViewController
@synthesize mapView;
@synthesize tblBusiness;
@synthesize locationManager;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_colorful_0710.png"]];

    
    NSURL *urlinfo = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/101222705/business.xml"];
    BusinessInfo  = [self getBusinessInfo:urlinfo];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    
    [locationManager startUpdatingLocation];
    
    [self goToCoordinateLocationlatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude title:@" " snippet:@" "];
    
    
        
}

-(void)goToCoordinateLocationlatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)longit title:(NSString*)locationTitle snippet:(NSString*)locationsnippet{
    //Google map
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat longitude:longit zoom:6];
    mapView_ = [GMSMapView mapWithFrame:mapView.bounds camera:camera];
    mapView_.myLocationEnabled = YES;
    
    [mapView addSubview:mapView_];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(lat, longit);
    marker.title = locationTitle;
    marker.snippet = locationsnippet;
    marker.map = mapView_;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* lat  = [BusinessLat objectAtIndex:indexPath.row];
    double latitude =[lat doubleValue];
    
    NSString* longitu  = [BusinessLong objectAtIndex:indexPath.row];
    double longitude =[longitu doubleValue];

    NSString* city  = [BusinessCity objectAtIndex:indexPath.row];
    NSString* state  = [BusinessState objectAtIndex:indexPath.row];

    [self goToCoordinateLocationlatitude:latitude longitude:longitude title:city snippet:state];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [BusinessInfoName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *businessTableIdentifier = @"BusinessTableCell";
    
    BusinessTableCell *cell = (BusinessTableCell *)[tableView dequeueReusableCellWithIdentifier:businessTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BusinessTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblName.text = [BusinessInfoName objectAtIndex:indexPath.row];
    cell.lblCategory.text = [BusinessInfoCategory objectAtIndex:indexPath.row];
    cell.lblLocation.text = [BusinessInfoLocation objectAtIndex:indexPath.row];
    cell.lblContactNo.text = [BusinessInfoContact objectAtIndex:indexPath.row];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)getBusinessInfo:(NSURL *)url {
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:response options:0 error:&err];
    
    
    NSError *error = nil;
    NSArray *data = [xmlDocument nodesForXPath:@"//business" error:&error];
    NSArray *data_location = [xmlDocument nodesForXPath:@"//location" error:&error];

    //NSArray *data = [[xmlDocument rootElement]elementsForName:@"business"];
    
    NSMutableArray *businame = [[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *busilocation = [[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *busicategory = [[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *busicontact = [[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *businessInfo = [[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *businessLatitide=[[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *businessLongitude=[[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *businessCity=[[NSMutableArray alloc] initWithCapacity: data.count];
    NSMutableArray *businessState=[[NSMutableArray alloc] initWithCapacity: data.count];


    
    for (GDataXMLElement *e in data){

        NSString *name;
        // Name
        NSArray *names = [e elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
            name = firstName.stringValue;
        } else continue;
        
        
        NSString *location;
        // location
        NSArray *loc = [e elementsForName:@"location"];
        if (loc.count > 0) {
            GDataXMLElement *locPlace = (GDataXMLElement *) [loc objectAtIndex:0];
            location = locPlace.stringValue;
        } else continue;

        
        NSString *category;
        // category
        NSArray *cat = [e elementsForName:@"category"];
        if (cat.count > 0) {
            GDataXMLElement *categ = (GDataXMLElement *) [cat objectAtIndex:0];
            category = categ.stringValue;
        } else continue;

        
    
        NSString *contact;
        // contact
        NSArray *con = [e elementsForName:@"phone"];
        if (con.count > 0) {
            GDataXMLElement *cont = (GDataXMLElement *) [con objectAtIndex:0];
            contact = cont.stringValue;
        } else continue;

        
        //For location coordinates
        
        NSString *latitude;
        NSString *longitude;
        NSString *busState;
        NSString *busCity;

        for (GDataXMLElement *e in data_location){
            
            // latitude
            NSArray *lat = [e elementsForName:@"latitude"];
            if (lat.count > 0) {
                GDataXMLElement *lati = (GDataXMLElement *) [lat objectAtIndex:0];
                latitude = lati.stringValue;
            } else continue;
            
            
            // longitude
            NSArray *longi = [e elementsForName:@"longitude"];
            if (longi.count > 0) {
                GDataXMLElement *longit = (GDataXMLElement *) [longi objectAtIndex:0];
                longitude = longit.stringValue;
            } else continue;
            
            // city
            NSArray *city = [e elementsForName:@"city"];
            if (city.count > 0) {
                GDataXMLElement *cit = (GDataXMLElement *) [city objectAtIndex:0];
                busCity = cit.stringValue;
            } else continue;
            
            // state
            NSArray *state = [e elementsForName:@"state"];
            if (state.count > 0) {
                GDataXMLElement *stat= (GDataXMLElement *) [state objectAtIndex:0];
                busState = stat.stringValue;
            } else continue;

            
        }
        
        
        [businame addObject:name];
        [busilocation addObject:location];
        [busicontact addObject:contact];
        [busicategory addObject:category];
        [businessLatitide addObject:latitude];
        [businessLongitude addObject:longitude];
        [businessState addObject:busState];
        [businessCity addObject:busCity];

        
        [businessInfo addObject:e];

    
    }
    
    BusinessInfoName = businame;
    BusinessInfoLocation=busilocation;
    BusinessInfoCategory=busicategory;
    BusinessInfoContact=busicontact;
    BusinessLat=businessLatitide;
    BusinessLong=businessLongitude;
    BusinessState=businessState;
    BusinessCity=businessCity;
    
    return businessInfo;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
