//
//  ViewController.m
//  MyLocation
//
//  Created by Deep Sidhpura on 8/18/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager=[[CLLocationManager alloc] init];
    geocoder=[[CLGeocoder alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentLocation:(id)sender {
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"didFailWithError:%@",error);
    UIAlertView *errorAlert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed To Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSLog(@"didUpdateLocation:%@",newLocation);
    CLLocation *currentLocation=newLocation;
    
    if (currentLocation !=nil) {
        self.longitudeLabel.text=[NSString stringWithFormat:@"% .8f",currentLocation.coordinate.longitude];
        self.latitudeLabel.text=[NSString stringWithFormat:@"% .8f",currentLocation.coordinate.latitude];
    }
    
    [locationManager stopUpdatingLocation];
    
    //Reverse Geocoding
    NSLog(@"Resolving the address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarkers :%@ , error:%@",placemarks,error);
        if (error==nil && [placemarks count] >0) {
            placemark=[placemarks lastObject];
            self.addressLabel.text=[NSString stringWithFormat:@"%@ %@ \n %@ %@ \n %@ \n %@ ",placemark.subThoroughfare,placemark.thoroughfare,placemark.postalCode,placemark.locality,placemark.administrativeArea,placemark.country];
            
        }
        else{
            NSLog(@"%@",error.debugDescription);
            
        }
        
    }];
    
    
}





@end
