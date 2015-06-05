//
//  mainVC.h
//  IOSAssignment
//
//  Created by Geoffrey Mok on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface mainVC : UIViewController <UIAccelerometerDelegate, NSFetchedResultsControllerDelegate>{

	float threshold;
	float strideLength;
	
	bool bStart;
	
	int duration;
	int steps;
	float distance;
	
	NSTimer *myTimer;
	
@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	NSManagedObject *currentObject;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObject *currentObject;

@property (nonatomic, retain) IBOutlet UILabel *lblSteps;
@property (nonatomic, retain) IBOutlet UILabel *lblDuration;
@property (nonatomic, retain) IBOutlet UILabel *lblDistance;
@property (nonatomic, retain) IBOutlet UIButton *btnStartStop;

- (void) newEntry;
- (IBAction) startStop:(id)sender;
- (IBAction) reset:(id)sender;
- (IBAction) save:(id)sender;
- (void) timePassed;
- (NSString *) getPathAndFilename;

@end
