//
//  MasterViewController.h
//  RSS Reader
//
//  Created by Deep Sidhpura on 8/16/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
