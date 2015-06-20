//
//  GlobalData.h
//  Stadium
//
//  Created by Mani Kishore Chitrala on 6/20/15.
//  Copyright (c) 2015 Mani Kishore Chitrala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Spotify/Spotify.h>

@interface GlobalData : NSObject

+ (GlobalData *)sharedGlobalData;
@property (nonatomic, strong) SPTSession *session;

@end
