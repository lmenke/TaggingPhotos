//
//  CollectionViewController.m
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import "CollectionViewController.h"
#import "NewMainOperation.h"
#import "ImageProperties.h"

@interface CollectionViewController ()
@property (strong, nonatomic) NSArray          *imageCollection; // Store processed data into array for display.
@property (strong, nonatomic) WebConnection    *webConnection;   // Web connection class and methods.
@property (strong, nonatomic) JSON             *JSONParser;      // JSON parser class and methods.
@property (strong, nonatomic) NSURL            *currentURL;      // Current URL.
@property (strong, nonatomic) NSOperationQueue *imageQueue;      // Image from operation queue.
@property BOOL                                  isFetchingData;  // Set to allow for next download trigger from cellForItemAtIndexpath.
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    // Initialize operation queue, data array, and web connection.
    self.imageQueue      = [[NSOperationQueue alloc] init];
    self.imageCollection = [[NSArray alloc] init];
    self.webConnection   = [[WebConnection alloc] init];
    
    // Set delegate.
    [self.webConnection setDelegate:self];
    
    // Set URL and the web connection.
    NSString *clientIDStr        = @"e178eb183d2249f0bad6330f04ec9619";
    NSString *instagramStr1      = [@"https://api.instagram.com/v1/tags/" stringByAppendingString:self.hashTagStr];
    NSString *instagramStr2      = [instagramStr1 stringByAppendingString:@"/media/recent?client_id="];
    NSString *instagramUserIDStr = [instagramStr2 stringByAppendingString:clientIDStr];
    NSLog(@"Connection string:  %@", instagramUserIDStr);
    self.currentURL              = [NSURL URLWithString:instagramUserIDStr];
    [self.webConnection startWebConnectionURL:self.currentURL];
    
    // Set JASON delegate.
    self.JSONParser = [[JSON alloc] init];
    [self.JSONParser setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

// One section as usual.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// Size of array collection.
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [self.imageCollection count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Start web connection URL and set the fetching data logical.
    if ((indexPath.row / (float)self.imageCollection.count) >= 0.75f && !self.isFetchingData)
    {
        [self.webConnection startWebConnectionURL:self.currentURL];
        self.isFetchingData = YES;
    }
    
    // Define the cell for the collection view for a given index value.
    UICollectionViewCell *cell     = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ImageProperties *currentSelfie = [self.imageCollection objectAtIndex:indexPath.row];
    cell.alpha                     = 0;
    
    // If low resolution.
    if (currentSelfie.imgLowRes)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:currentSelfie.imgLowRes];
        [cell setBackgroundView:imgView];
        cell.alpha           = 1.0f;
    }
    // Otherwise
    else
    {
        NewMainOperation *myOperation = [[NewMainOperation alloc] init];
        [myOperation setSelfie:currentSelfie];
        [myOperation setIndexPath:indexPath];
        [myOperation setCollectionCell:cell];
        
        [self.imageQueue addOperation:myOperation];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

// Fitting the images into the collection view.
- (CGSize) collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int largeImageSize = 300;
    int smallImageSize = 145;
    if (indexPath.row % 3 == 0)
    {
        return CGSizeMake(largeImageSize, largeImageSize);
    }
    else
    {
        return CGSizeMake(smallImageSize, smallImageSize);
    }
}

// End of cell.
-(void)collectionView:(UICollectionView *)collectionView
 didEndDisplayingCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (NewMainOperation *checkOperation in [self.imageQueue operations])
    {
        if (checkOperation.indexPath == indexPath)
        {
            [checkOperation cancel];
        }
    }
}


#pragma mark - Web Connection Delegate Methods
-(void) webConnectionSuccess:(NSData *) responseData
{
    [self.JSONParser startJSON:responseData];
}

-(void) webConnectionFailure:(NSError *)error
{
    NSLog(@"Web connection failure delegate operation");
}


#pragma mark - JSON Parsing Delegate Methods
-(void) jsonSuccess:(NSMutableArray *) parsedObjects
{
    self.currentURL      = [parsedObjects lastObject];
    [parsedObjects removeLastObject];
    self.imageCollection = [self.imageCollection arrayByAddingObjectsFromArray:[parsedObjects copy]];
    [self.collectionView reloadData];
    self.isFetchingData  = NO;
}

-(void) jsonFailure:(NSError *)parseError
{
    NSLog(@"JSON parsing failure delegate operation");
}

@end
