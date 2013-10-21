//
//  JMAParser.m
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/20/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import "JMAParser.h"

@implementation JMAParser

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
    This method acts as the controller for the class's
    intended operation.
*/

- (void)parseFileForUrl:(NSURL *)url
{
    NSString *fileContents = [self stringForURL:url];
}

/*
 The method will initialize a string with the contents of a url parameter
 and return the string.
 
 */
- (NSString *)stringForURL:(NSURL *)url
{
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfURL:url
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return @"Error";
    } else {
        return fileContents;
    }
}


@end
