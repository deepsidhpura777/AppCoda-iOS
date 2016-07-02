//
//  DeviceViewController.m
//  CoreDataTutorial
//
//  Created by Deep Sidhpura on 8/2/14.
//  Copyright (c) 2014 Deep Sidhpura. All rights reserved.
//

#import "DeviceViewController.h"
#import "DeviceDetailViewController.h"

@interface DeviceViewController ()

@property(strong) NSMutableArray *devices;

@end

@implementation DeviceViewController

-(NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObjectContext *context=nil;
    id delegate=[[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context=[delegate managedObjectContext];
    }
    return context;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext=[self managedObjectContext];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] initWithEntityName:@"Device"];
    self.devices=[[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy]; //Storing all NSManagedObjects for each device in the database.One tuple
    [self.tableView reloadData];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *device=[self.devices objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@" , [device valueForKey:@"name"],[device valueForKey:@"version"]]];
    [cell.detailTextLabel setText:[device valueForKey:@"company"]];
    cell.imageView.image=[UIImage imageNamed:@"Apple_Logo"];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    return YES;
}

//didSelectRowAtIndexPath to check if a row is selected or not


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]]; //If we wanna delete NSManagedObject for each data from the context.
        
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Cant delete %@ %@",error,[error localizedDescription]);
            return;
        }
        [self.devices removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Update"]) {
        NSManagedObject *selectDevice=[self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        DeviceDetailViewController *destViewController=segue.destinationViewController;
        destViewController.device=selectDevice;
    }
}

 

@end
