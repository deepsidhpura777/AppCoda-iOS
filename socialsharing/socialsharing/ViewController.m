//
//  ViewController.m
//  SocialSharing
//
//  Created by Deep Sidhpura on 8/16/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)postToTwitter:(id)sender {
    
    NSLog(@"Twitter Clicked");
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Hi Everyone"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
        NSLog(@"Inside Twitter");
        
    }
}

- (IBAction)postToFacebook:(id)sender {
    
    NSLog(@"Facebook Clicked");
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:@"Hi Everyone"];
        [controller addURL:[NSURL URLWithString:@"http://www.google.com"]];
        [self presentViewController:controller animated:YES completion:nil];
        
        NSLog(@"Inside Facebook");
        
    }
}


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

@end
