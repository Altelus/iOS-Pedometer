//
//  mainVC.m
//  IOSAssignment
//
//  Created by Geoffrey Mok on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "mainVC.h"
#import "logVC.h"
#import "settings.h"

@implementation mainVC

@synthesize lblSteps, lblDuration, lblDistance, btnStartStop;
@synthesize fetchedResultsController, managedObjectContext, currentObject;

#pragma mark -
#pragma mark View lifecycle

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	

	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	// The setUpdateInterval property is measured in seconds
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.5];
	
	threshold = 0.3;
	steps = 0;
	
	bStart = NO;
	
	strideLength = 0.762;
	distance = 0;
	
	duration = 0;
	myTimer = NULL;
	
	// Setup an error object
	NSError *error;
	// Fetch the initial result set; as noted in the interface, we use a fetched results controller here
	// If there is a problem performing the fetch...
	if (![[self fetchedResultsController] performFetch:&error]) {
        // Handle the error (and handle it better in a production app)
	}
	
	// Provide a starting value for the view in portrait mode
	// Do this by calling didRotate..., and supply a non-portrait mode
	//[self didRotateFromInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	settings *sVC = [self.tabBarController.viewControllers objectAtIndex:3];

	//retrieve values from settings
	if (sVC.view)
	{
		int g = [sVC.segGender selectedSegmentIndex];
		threshold = [sVC.sldSensitivity value];
		
		//offset index of height by 48(inches)
		int height = 48+[sVC.pvHeight selectedRowInComponent:0];
		//convert to meters
		height *= 0.0254;
		
		//calculate stride length based on gender
		if (g) strideLength = height * 0.413;
		else strideLength = height * 0.415;
	}
	
}

// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    //if (managedObjectContext == nil) { managedObjectContext = [(IOSAssignmentAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; }
	
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
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"dateTime" ascending:YES];
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
#pragma mark Delegate methods

// DELEGATE METHOD
// This will work on the device, but not on the simulator
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
	if (bStart){
	
		//simple step algorithm
		int cx = acceleration.x;
		int cy = acceleration.y;
		int cz = acceleration.z;
	
		//calculate amount of gravity
		float accel = sqrt(cx * cx + cy * cy + cz * cz) -1;
	
		if (accel < 0) accel *= -1;

		//increment steps
		if (accel > threshold)
		{
			lblSteps.text = [NSString stringWithFormat:@"%d", ++steps];
			lblDistance.text = [NSString stringWithFormat:@"%.2f(m)", distance += strideLength];
		}
	}
}

#pragma mark -
#pragma mark User Methods
- (IBAction) startStop:(id)sender
{
	//if pedometer is on
	if (bStart){
		bStart = NO;
		[btnStartStop setTitle:@"Start" forState:UIControlStateNormal];
		
		if (myTimer)
			[myTimer invalidate];
	}
	// if pedometer is off
	else {
		bStart = YES;
		[btnStartStop setTitle:@"Stop" forState:UIControlStateNormal];
		
		myTimer = [NSTimer scheduledTimerWithTimeInterval:1
					target:self 
					selector:@selector(timePassed) 
					userInfo:nil 
					repeats:YES];
	}

}

//reset all values and stops pedometer
- (IBAction) reset:(id)sender
{
	bStart = YES;
	[self startStop:self];
	lblSteps.text = [NSString stringWithFormat:@"%d", steps=0];
	lblDistance.text = [NSString stringWithFormat:@"%.2f(m)", distance=0];
	lblDuration.text = [NSString stringWithFormat:@"%d", duration=0];
}

//creates NSManagedObject to be used as a new entry
- (void) newEntry
{
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
	currentObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
}

//saves the pedometer session
- (IBAction) save:(id)sender
{
	[self newEntry];
	
	NSDate *timeStamp = [NSDate date];
	// Pass values to new object
	[currentObject setValue:[NSNumber numberWithInt:duration] forKey:@"duration"];
	[currentObject setValue:[NSNumber numberWithInt:steps] forKey:@"steps"];
	[currentObject setValue:[NSNumber numberWithFloat:distance] forKey:@"distance"];
	[currentObject setValue:timeStamp forKey:@"dateTime"];
	
	// Save the context
	NSError *error;
	if (![[currentObject managedObjectContext] save:&error]) {
		// Handle the error (and do it better in a production app)
	}
	
	currentObject = nil;
}


//called by timer object when pedometer is on
- (void) timePassed
{
	duration++;
	
	//set timer label display
	int seconds = duration % 60;
	int minutes = (duration - seconds) / 60;
	
	lblDuration.text = [NSString stringWithFormat:@"%.2d:%.2d", minutes, seconds];
}

// INSTANCE METHOD - get the path and file name for the saved plist
- (NSString *) getPathAndFilename {
	
	// The code in this method is intentionally verbose to clearly show all the moving parts
	
	// Get all available file system paths for the user
	NSArray *paths = 
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// Get the "Documents" directory path - it's the one and only on iPhone OS
	NSString *documentsPath = [paths objectAtIndex:0];
	
	// Specify the file name, appending it to documentsPath above
	NSString *savedFileName = 
	[documentsPath stringByAppendingPathComponent:@"IOSAssignmentSettings.plist"];
	
	// We're done
	return savedFileName;
	
}

@end
