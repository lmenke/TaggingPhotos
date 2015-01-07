//
//  NewMainOperation.m
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import "NewMainOperation.h"

@implementation NewMainOperation

// Set with low resolution.
- (void) main
{
    [self.selfie setImgLowRes:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.selfie.strURLLowRes]]]];
    
    // Just return for now.
    if (self.isCancelled)
    {
        return;
    }
    
    // Now a asynchronize dispatch a call to the main queue.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionCell setBackgroundView:[[UIImageView alloc]initWithImage:self.selfie.imgLowRes]];
        
        // Perform the animations then return alpha to 1.
        double time  = 0.25f;
        double alpha = 1.0f;
        [UIView animateWithDuration:time animations:^{
            self.collectionCell.alpha = alpha;
        }];
    });
}

@end
