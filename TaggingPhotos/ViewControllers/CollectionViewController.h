//
//  CollectionViewController.h
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebConnection.h"
#import "JSON.h"
#import "ImageProperties.h"

// Add the new delegates created for web connection and JSON parsing.
@interface CollectionViewController : UICollectionViewController<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    WebConnectionDelegate,
    JSONDelegate>

@property (strong, nonatomic) NSString                  *hashTagStr;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
