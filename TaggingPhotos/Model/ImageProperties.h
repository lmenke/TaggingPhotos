//
//  ImageProperties.h
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProperties : NSObject

// Simply a list of properties that an image may possess.  Add more as needed.

// String for thumb view, low resolution and standard resolution cases.
@property (strong, nonatomic) NSString *strURLThumb;
@property (strong, nonatomic) NSString *strURLLowRes;
@property (strong, nonatomic) NSString *strURLStdRes;

// Images for thumb view, low resolution and standard resolution cases.
@property (strong, nonatomic) UIImage  *imgThumb;
@property (strong, nonatomic) UIImage  *imgLowRes;
@property (strong, nonatomic) UIImage  *imgStdRes;

// User input message.
@property (strong, nonatomic) NSString *strInput;

@end
