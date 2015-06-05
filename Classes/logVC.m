//
//  logVC.m
//  IOSAssignment
//
//  Created by Geoffrey Mok on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "logVC.h"
#import "IOSAssignmentAppDelegate.h"
#import "mainVC.h"

@implementation logVC
@synthesize fetchedResultsController, managedObjectContext;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Step Log";
	self.tableView.rowHeight = 100;
	
	//self.navigationItem.leftBarButtonItem = self.editButtonItem;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
	// Setup an error object
	NSError *error;
	// Fetch the initial result set; as noted in the interface, we use a fetched results controller here
	// If there is a problem performing the fetch...
	if (![[self fetchedResultsController] performFetch:&error]) {
        // Handle the error (and handle it better in a production app)
	}
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
	NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
	
	// Title - Date
	UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 20)];
	lblTitle.text = [[managedObject valueForKey:@"dateTime"]description];
	lblTitle.font = [UIFont boldSystemFontOfSize:15];
	[cell.contentView addSubview:lblTitle];
	
	// Duration
	
	int duration = [[managedObject valueForKey:@"duration"]intValue];
	int seconds = duration % 60;
	int minutes = (duration - seconds) / 60;
	
	UILabel *lblDuration = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 20)];
	lblDuration.text = [NSString stringWithFormat:@"Duration: %.2d:%.2d", minutes, seconds];
	lblDuration.font = [UIFont italicSystemFontOfSize:14];
	[cell.contentView addSubview:lblDuration];
			
	// Steps
	UILabel *lblSteps = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 20)];
	lblSteps.text = [NSString stringWithFormat:@"Steps: %d",
						[[managedObject valueForKey:@"steps"]intValue]];
	lblSteps.font = [UIFont italicSystemFontOfSize:14];
	[cell.contentView addSubview:lblSteps];
			
	// Distance
	UILabel *lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 20)];
	lblDistance.text = [NSString stringWithFormat:@"Distance: %.2f meters",
					 [[managedObject valueForKey:@"distance"]floatValue]];
	lblDistance.font = [UIFont italicSystemFontOfSize:14];
	[cell.contentView addSubview:lblDistance];
    
    [lblTitle, lblDuration, lblSteps, lblDistance release];
	
	//disable selection of cells
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

return cell;
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    if (managedObjectContext == nil) { managedObjectContext = [(IOSAssignmentAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; }
	
	/*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StepLog" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"dateTime" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor1 release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}    

#pragma mark -
#pragma mark Fetched results controller delegate

/*
 - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
 [self.tableView beginUpdates];
 }
 
 
 - (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
 atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
 
 switch(type) {
 case NSFetchedResultsChangeInsert:
 [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
 break;
 
 case NSFetchedResultsChangeDelete:
 [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
 break;
 }
 }
 
 
 - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
 atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
 newIndexPath:(NSIndexPath *)newIndexPath {
 
 UITableView *tableView = self.tableView;
 
 switch(type) {
 
 case NSFetchedResultsChangeInsert:
 [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
 break;
 
 case NSFetchedResultsChangeDelete:
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 break;
 
 case NSFetchedResultsChangeUpdate:
 [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
 break;
 
 case NSFetchedResultsChangeMove:
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
 break;
 }
 }
 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 [self.tableView endUpdates];
 }
 
 
 */
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

