//
//  NetworkService.h
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface NetworkService : NSObject

+ (NetworkService *)sharedService;

- (void)getJSONAtPath:(NSString *)aPath
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))onSuccess
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))onFailure;

- (void)postJSONObject:(id)JSONObject
                toPath:(NSString *)aPath
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))onSuccess
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))onFailure;

- (void)getItems;

- (void)newItem;

@end
