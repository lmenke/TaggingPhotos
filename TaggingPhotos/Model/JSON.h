//
//  JSON.h
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONDelegate <NSObject>
- (void) jsonSuccess:(NSMutableArray *) parsedObjects;
- (void) jsonFailure:(NSError *)        parseError;
@end

@interface JSON : NSObject

@property (weak, nonatomic) id delegate;

- (void) startJSON:(NSData *) webData;

@end