//
//  Result.h
//  Stadium
//
//  Created by Mani Kishore Chitrala on 6/20/15.
//  Copyright (c) 2015 Mani Kishore Chitrala. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Result : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSNumber *spotifyScore;

@end
