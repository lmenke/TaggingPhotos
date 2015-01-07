//
//  ViewController.h
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

/*
 Using the Instagram API, create an iPhone app that displays photos tagged with hashtag #selfie and arranges them using the pattern: big, small, small (repeating). Then implement one of the following features: Tap to enlarge, Drag and drop reordering, or Infinite scrolling. Scrolling should be smooth so performance is essential. Complete as much as you can within one day. Be creative and have fun. Good luck!
 */

// Infinite scrolling version.

#import <UIKit/UIKit.h>

// Simple introduction page.
// Press the start button to view the selfies.
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *enterHashTag;

- (IBAction)pressToStart:(id)sender;

@end

