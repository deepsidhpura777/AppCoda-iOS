//
//  AddToDoViewController.m
//  Local Notifications
//
//  Created by Deep Sidhpura on 8/16/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import "AddToDoViewController.h"

@interface AddToDoViewController ()

@end

@implementation AddToDoViewController

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    [self.itemText resignFirstResponder];
    
    NSDate *pickerDate=[self.datePicker date];
    
    //Schedule The Notification
    
    UILocalNotification *localNotification=[[UILocalNotification alloc]init];
    localNotification.fireDate=pickerDate;
    localNotification.alertBody=self.itemText.text;
    localNotification.alertAction=@"Show Me The Item";
    localNotification.timeZone=[NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber=[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1 ;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    //Request to reload the data
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



@end
