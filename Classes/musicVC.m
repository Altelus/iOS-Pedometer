//
//  musicVC.m
//  IOSAssignment
//
//  Created by Geoffrey Mok on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "musicVC.h"


@implementation musicVC
@synthesize mPlayer, artist, song, album, cover, btnPlayStop;

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
	
	// instantiate a music player
	mPlayer = [MPMusicPlayerController applicationMusicPlayer];
	
	// assign a playback queue containing all media items on the device
    [mPlayer setQueueWithQuery: [MPMediaQuery songsQuery]];

//	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
//	
//	[notificationCenter
//	 addObserver: self
//	 selector:    @selector (handle_NowPlayingItemChanged:)
//	 name:        MPMusicPlayerControllerNowPlayingItemDidChangeNotification
//	 object:      mPlayer];
//	
//	[notificationCenter
//	 addObserver: self
//	 selector:    @selector (handle_PlaybackStateChanged:)
//	 name:        MPMusicPlayerControllerPlaybackStateDidChangeNotification
//	 object:      mPlayer];
//	
//	[notificationCenter
//	 addObserver: self
//	 selector:    @selector (handle_VolumeDidChange:)
//	 name:        MPMusicPlayerControllerVolumeDidChangeNotification
//	 object:      mPlayer];
//	
//	[mPlayer beginGeneratingPlaybackNotifications];
	
	//[[MPMediaLibrary defaultMediaLibrary] beginGeneratingLibraryChangeNotifications];
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
    [super dealloc];
}

- (IBAction) playStop:(id)sender
{
	[mPlayer play];
	MPMediaItem *currentItem = mPlayer.nowPlayingItem;
		
	// Display the artist, album, and song name for the now-playing media item.
	// These are all UILabels.
	self.song.text   = [currentItem valueForProperty:MPMediaItemPropertyTitle];
	self.artist.text = [currentItem valueForProperty:MPMediaItemPropertyArtist];
	self.album.text  = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];    
    
    MPMediaItemArtwork *aCover = [currentItem valueForProperty:MPMediaItemPropertyArtwork];

	self.cover.image = [aCover imageWithSize:cover.bounds.size];
}
 //When the now playing item changes, update song info labels and artwork display.
- (void)handleNowPlayingItemChanged:(id)notification {
    // Ask the music player for the current song.
//    MPMediaItem *currentItem = self.mPlayer.nowPlayingItem;
	
    // Display the artist, album, and song name for the now-playing media item.
    // These are all UILabels.
//    self.song.text   = [currentItem valueForProperty:MPMediaItemPropertyTitle];
//    self.artist.text = [currentItem valueForProperty:MPMediaItemPropertyArtist];
//    self.album.text  = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];    
//	
    // Display album artwork. self.artworkImageView is a UIImageView.
    //CGSize artworkImageViewSize = self.artworkImageView.bounds.size;
    //MPMediaItemArtwork *artwork = [currentItem valueForProperty:MPMediaItemPropertyArtwork];
    //if (artwork != nil) {
    //    self.artworkImageView.image = [artwork imageWithSize:artworkImageViewSize];
    //} else {
    //    self.artworkImageView.image = nil;
    //}
}

// When the playback state changes, set the play/pause button appropriately.
- (void)handlePlaybackStateChanged:(id)notification {
    //MPMusicPlaybackState playbackState = self.musicPlayer.playbackState;
   // if (playbackState == MPMusicPlaybackStatePaused || playbackState == MPMusicPlaybackStateStopped) {
    //    [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
    //} else if (playbackState == MPMusicPlaybackStatePlaying) {
    //    [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    //}
}

// When the volume changes, sync the volume slider
- (void)handleExternalVolumeChanged:(id)notification {
    // self.volumeSlider is a UISlider used to display music volume.
    // self.musicPlayer.volume ranges from 0.0 to 1.0.
    //[self.volumeSlider setValue:self.musicPlayer.volume animated:YES];
}

@end
