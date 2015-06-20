//
//  Result.m
//  Stadium
//
//  Created by Mani Kishore Chitrala on 6/20/15.
//  Copyright (c) 2015 Mani Kishore Chitrala. All rights reserved.
//

#import "Result.h"

@implementation Result

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"username" : @"name",
             @"lat" : @"lat",
             @"lon" : @"lon",
             @"spotifyScore":@"spotify_score"
             };
}

@end
