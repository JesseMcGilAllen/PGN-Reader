//
//  JMAParser.h
//  PGN Reader
//
//  Created by Jesse McGil Allen on 10/20/13.
//  Copyright (c) 2013 Jesse McGil Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMADatabasesTableViewController;

@interface JMAParser : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)parseFileWithUrl:(NSURL *)url
  forTableViewController:(JMADatabasesTableViewController *)tableViewController;

@end
