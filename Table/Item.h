//
//  Item.h
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSNumber* identifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *available;
@property (nonatomic, strong) NSURL* imageUrl;
@property (nonatomic, strong) NSString* description;

- (id)initWithJSONObject:(NSDictionary *)JSONObject;

- (NSDictionary *)JSONObject;

- (void) downloadImage:(void (^)(UIImage* image))onSuccess failure:(void (^)())onFailure;

@end
