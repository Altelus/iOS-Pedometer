//
//  settings.m
//  IOSAssignment
//
//  Created by Geoffrey Mok on 10-12-05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "settings.h"
#import "mainVC.h"


@implementation settings
@synthesize sldSensitivity, lblSensitivity, segGender, pvHeight, arrHeights, dict;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


//setup inital values and retrieves settings
- (void)awakeFromNib {
	NSLog(@"awakeFromNib");
	mainVC *mVC = [self.tabBarController.viewControllers objectAtIndex:0];
	
	dict = [NSDictionary dictionaryWithContentsOfFile:[mVC.self getPathAndFilename]];

	arrHeights = [[NSMutableArray alloc] init];
	
	for (int i = 48; i < 109; i++){
		[arrHeights addObject:[NSNumber numberWithFloat:i]];
	}
	
	[arrHeights retain];
	
	[dict retain];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSLog(@"viewDidLoad");
	
	//log dictionary data
//	for (id key in dict) {
//		
//		NSLog(@"key: %@, value: %@", key, [dict objectForKey:key]);
//		
//	}
	
	//configure settings from the plist
	if (dict)
	{
		NSLog(@"dict");
		sldSensitivity.value = [[dict valueForKey:@"sensitivity"]floatValue];
		lblSensitivity.text = [NSString stringWithFormat:@"%.2f",[[dict valueForKey:@"sensitivity"]floatValue]];
		segGender.selectedSegmentIndex = [[dict valueForKey:@"gender"] intValue];
		[pvHeight selectRow:([[dict valueForKey:@"height"] intValue])
				inComponent:(0) 
				   animated:(YES)];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[arrHeights release];
    [super dealloc];
}


//update the sensitiity label
-(IBAction)sliderChanged:(id)sender{
	
	lblSensitivity.text = [NSString stringWithFormat:@"%.2f", [sldSensitivity value]]; 
}

#pragma mark -
#pragma mark Delegate and data source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pvNFLTeams {
	return 1;
}

// DATA SOURCE METHOD...
// Number of rows in picker view
- (NSInteger)pickerView:(UIPickerView *)pvPrices numberOfRowsInComponent:(NSInteger)component {
	return [arrHeights count];
}

// DELEGATE METHOD...
// Set the visible text for the picker row; gets called once for EACH row
- (NSString *)pickerView:(UIPickerView *)pvPrices 
			 titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component {
	
	//formats arrHeights to show feet/inches
	int inches = [[arrHeights objectAtIndex:row] intValue] % 12;
	int feet = ([[arrHeights objectAtIndex:row] intValue] - inches) / 12;
	
	return [NSString stringWithFormat:@"%d'%d", feet, inches];

}

@end
