//
//  NewMainOperation.h
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageProperties.h"

@interface NewMainOperation : NSOperation

@property (weak, nonatomic) NSIndexPath          *indexPath;        // Indcies.
@property (weak, nonatomic) UICollectionViewCell *collectionCell;   // Working image cell.

@property (weak, nonatomic) ImageProperties      *selfie;           // A selfie.

@end
