//
//  settings.h
//  IOSAssignment
//
//  Created by Geoffrey Mok on 10-12-05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface settings : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
	NSDictionary *dict;
	NSMutableArray *arrHeights;
}
@property (nonatomic, retain) IBOutlet UISlider *sldSensitivity;
@property (nonatomic, retain) IBOutlet UILabel *lblSensitivity;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segGender;
@property (nonatomic, retain) IBOutlet UIPickerView *pvHeight;
@property (nonatomic, retain) NSMutableArray *arrHeights;
@property (nonatomic, retain) NSDictionary *dict;

- (IBAction)sliderChanged:(id)sender;

@end