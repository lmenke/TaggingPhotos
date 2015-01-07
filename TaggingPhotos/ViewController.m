//
//  ViewController.m
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

/*
 Using the Instagram API, create an iPhone app that displays photos tagged with hashtag #selfie and arranges them using the pattern: big, small, small (repeating). Then implement one of the following features: Tap to enlarge, Drag and drop reordering, or Infinite scrolling. Scrolling should be smooth so performance is essential. Complete as much as you can within one day. Be creative and have fun. Good luck!
 */

// Infinite scrolling version.

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initial hash tag.
    self.enterHashTag.text = @"selfie";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressToStart:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"start"])
    {
        [[segue destinationViewController] setHashTagStr:self.enterHashTag.text];
    }
}

@end
