//
//  ViewController.h
//  MyLocation
//
//  Created by Deep Sidhpura on 8/18/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>


@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)getCurrentLocation:(id)sender;


@end
