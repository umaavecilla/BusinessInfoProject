//
//  BussInfoViewController.m
//  BusinessInfo
//
//  Created by Apple Macintosh on 11/4/13.
//  Copyright (c) 2013 Apple Macintosh. All rights reserved.
//

#import "BussInfoViewController.h"

@interface BussInfoViewController ()

@end

@implementation BussInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
