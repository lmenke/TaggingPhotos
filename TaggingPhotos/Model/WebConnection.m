//
//  WebConnection.m
//  TaggingPhotos
//
//  Created by LHM on 1/6/15.
//  Copyright (c) 2015 LP&E. All rights reserved.
//

#import "WebConnection.h"

@interface WebConnection ()

@end

@implementation WebConnection

// Download the web connection using NSURL synchronous response/request within a block.
// Respond to success and failure blocks as is common.
-(void)startWebConnectionURL:(NSURL*)url
{
    // Get the current thread.
    NSThread *currentThread = [NSThread currentThread];
    
    // Set to weak because of outside the block needs.
    __weak WebConnection *weakSelf = self;
    
    // Make an asynchronous dispatch call and create a queue named "Web Connection Queue".
    dispatch_async(dispatch_queue_create("Web Connection Queue", NULL), ^{
        NSError       *error;
        NSURLResponse *nsurlResponse;
        NSURLRequest  *nsurlWebConnection = [[NSURLRequest alloc]initWithURL:url];
        NSData        *responseData       = [NSURLConnection sendSynchronousRequest:nsurlWebConnection
                                                                  returningResponse:&nsurlResponse
                                                                              error:&error];
        // Process depending on the error state.
        if (!error)
        {
            if ([weakSelf.delegate respondsToSelector:@selector(webConnectionSuccess:)])
            {
                [weakSelf.delegate performSelector:@selector(webConnectionSuccess:)
                                          onThread:currentThread
                                        withObject:responseData
                                     waitUntilDone:YES];
            } else {NSLog(@"Error in web connection success call.");}
        }
        else
        {
            if ([weakSelf.delegate respondsToSelector:@selector(webConnectionFailure:)])
            {
                [weakSelf.delegate performSelector:@selector(webConnectionFailure:)
                                          onThread:currentThread
                                        withObject:error
                                     waitUntilDone:YES];
            } else {NSLog(@"Error in web connection failure call.");}
        }
    });
}

@end
