//
//  Item.m
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "Item.h"

@interface Item()
	@property (nonatomic, strong) UIImage* image;
@end

@implementation Item

@synthesize image = _image;

- (id)initWithJSONObject:(NSDictionary *)JSONObject
{
    self = [super init];
    if (self) {
        TRC_OBJ(JSONObject);
        
		_identifier = [NSNumber numberWithInt:[JSONObject[@"id"] intValue]];
        _title = [JSONObject[@"title"] stringValue];
        _subtitle = [JSONObject[@"subtitle"] stringValue];
//        NSNumber *number = JSONObject[@"price"];
//        if ((NSNull *)number != [NSNull null]) {
//            _price = number.floatValue;
//        }
        _price = [JSONObject[@"price"] floatValue];
        
        NSString *dateString = JSONObject[@"available"];
        if ((NSNull *)dateString != [NSNull null]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            _available = [formatter dateFromString:dateString];
        }
		
		NSString *createdAtString = JSONObject[@"created_at"];
        if ((NSNull *)createdAtString != [NSNull null]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
            _createdAt = [formatter dateFromString:createdAtString];
        }
		
		NSString* imageUrlStr = JSONObject[@"imageurl"];
		if ((NSNull *)imageUrlStr != [NSNull null]) {
			_imageUrl = [NSURL URLWithString:imageUrlStr];
		}
    }
    
    return self;
}

- (NSDictionary *)JSONObject
{
    /*
     Do NSDictionaty @ { key : value} nesmi prijit nil, takze tam dame zastupny objekt [NSNull null]
     */
    
    return @{
	@"item[id]" : _identifier ? _identifier : [NSNull null],
    @"item[title]" : _title? _title : [NSNull null],
    @"item[subtitle]" : _subtitle? _subtitle : [NSNull null],
    @"item[description]" : [NSNull null],
    @"item[price]" : @(3.1415)
    };
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Item: %@, %@", _title, _subtitle];
}

- (void) downloadImage:(void (^)(UIImage* image))onSuccess failure:(void (^)())onFailure
{
	if (self.image) {
		onSuccess(self.image);
		return;
	}
	if (_imageUrl) {
		dispatch_async(dispatch_get_global_queue(0,0), ^{
			NSData * data = [[NSData alloc] initWithContentsOfURL:_imageUrl];
			if (data == nil) onFailure();
			DEFINE_BLOCK_SELF;
			dispatch_async(dispatch_get_main_queue(), ^{
				blockSelf.image = [UIImage imageWithData: data];
				onSuccess(blockSelf.image);
			});
		});
	} else {
		onFailure();
	}
}

@end
