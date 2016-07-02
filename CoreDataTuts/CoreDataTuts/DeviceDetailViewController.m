//
//  DeviceDetailViewController.m
//  CoreDataTutorial
//
//  Created by Deep Sidhpura on 8/2/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

@end

@implementation DeviceDetailViewController
@synthesize device;

-(NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObjectContext *context=nil;
    id delegate=[[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context=[delegate managedObjectContext];
    }
    return context;
}




- (IBAction)save:(id)sender {
    NSManagedObjectContext *context=[self managedObjectContext];
    
    
    if (self.device) {
        [self.device setValue:self.nameTextField.text forKey:@"name"];
        [self.device setValue:self.versionTextField.text forKey:@"version"];
        [self.device setValue:self.companyTextField.text forKey:@"company"];
        
    }
    else{
        NSManagedObject *newDevice=[NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newDevice setValue:self.nameTextField.text forKey:@"name"];
        [newDevice setValue:self.versionTextField.text forKey:@"version"];
        [newDevice setValue:self.companyTextField.text forKey:@"company"];
    }
    
    NSError *error=nil;
    if (![context save:&error]) {
        NSLog(@"Cant save! %@ %@",error,[error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
   
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.device) {
        [self.nameTextField setText:[self.device valueForKey:@"name"]];
        [self.versionTextField setText:[self.device valueForKey:@"version"]];
        [self.companyTextField setText:[self.device valueForKey:@"company"]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
