//
//  JSON.m
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import "JSON.h"
#import "ImageProperties.h"

@implementation JSON


// Download the web connection using NSURL synchronous response/request within a block.
// Respond to success and failure blocks as is common.
- (void) startJSON:(NSData *) webData
{
    // Get the current thread.
    NSThread *currentThread = [NSThread currentThread];
    
    // Set to weak because of outside the block needs.
    __weak JSON *weakSelf = self;
    
    // Make an asynchronous dispatch call and create a queue named "JASON Parsing Queue".
    // Store results in mutable array.
    dispatch_async(dispatch_queue_create("JASON Parsing Queue", NULL), ^{
        NSMutableArray *results  = [[NSMutableArray alloc] init];
        NSError        *error;
        NSDictionary   *jsonDict = [NSJSONSerialization JSONObjectWithData:webData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
        // Process depending on the error state.
        if (!error)
        {
            // Parse results into mutable array.
            NSArray *arryOfSelfies = [jsonDict objectForKey:@"data"];
            NSLog(@"Array size %lu", (unsigned long)arryOfSelfies.count);
            if (arryOfSelfies.count == 0)
            {
                NSLog(@"No cases found application terminating!");
                
                UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                                  message:@"No cases found application terminating!"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"OK", nil];
                dispatch_sync(dispatch_get_main_queue(), ^{[anAlert show];});
                
                // Force exit!
                exit(0);
            }
            
            for (NSDictionary *currentSelfy in arryOfSelfies)
            {
                ImageProperties *Selfie = [[ImageProperties alloc] init];
                Selfie.strURLLowRes     = [[[currentSelfy objectForKey:@"images"] objectForKey:@"low_resolution"]      objectForKey:@"url"];
                Selfie.strURLStdRes     = [[[currentSelfy objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
                Selfie.strURLThumb      = [[[currentSelfy objectForKey:@"images"] objectForKey:@"thumbnail"]           objectForKey:@"url"];
                Selfie.strInput         =  [[currentSelfy objectForKey:@"user"]   objectForKey:@"username"];
                
                [results addObject:Selfie];
            }
            
            NSURL *nextPageURL = [NSURL URLWithString:[[jsonDict objectForKey:@"pagination"] objectForKey:@"next_url"]];
            
            [results addObject:nextPageURL];
            
            if ([weakSelf.delegate respondsToSelector:@selector(jsonSuccess:)])
            {
                [weakSelf.delegate performSelector:@selector(jsonSuccess:)
                                          onThread:currentThread
                                        withObject:results
                                     waitUntilDone:YES];
            } else {NSLog(@"Error in JSON parsing success call.");}
        }
        else
        {
            if ([weakSelf.delegate respondsToSelector:@selector(jsonFailure:)])
            {
                [weakSelf.delegate performSelector:@selector(jsonFailure:)
                                          onThread:currentThread
                                        withObject:error
                                     waitUntilDone:YES];
            } else {NSLog(@"Error in JSON parsing failure call.");}
        }
    });
}

@end
