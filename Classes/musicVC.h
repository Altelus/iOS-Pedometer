//
//  musicVC.h
//  IOSAssignment
//
//  Created by Geoffrey Mok on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface musicVC : UIViewController {
	MPMusicPlayerController *mPlayer;
}

@property (nonatomic, retain) MPMusicPlayerController *mPlayer;
@property (nonatomic, retain) IBOutlet UILabel *artist;
@property (nonatomic, retain) IBOutlet UILabel *song;
@property (nonatomic, retain) IBOutlet UILabel *album;
@property (nonatomic, retain) IBOutlet UIImageView *cover;
@property (nonatomic, retain) IBOutlet UIButton *btnPlayStop;
@property (nonatomic, retain) IBOutlet UISlider *sldSeek;

- (IBAction) playStop:(id)sender;


@end
