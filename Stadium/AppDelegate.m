//
//  AppDelegate.m
//  Stadium
//
//  Created by Mani Kishore Chitrala on 6/18/15.
//  Copyright (c) 2015 Mani Kishore Chitrala. All rights reserved.
//


#import <Spotify/Spotify.h>
#import <GoogleMaps/GoogleMaps.h>

#import "AppDelegate.h"
#import "GlobalData.h"

@interface AppDelegate ()

@property (nonatomic, strong) SPTSession *session;
@property (nonatomic, strong) SPTAudioStreamingController *player;
@end


@implementation AppDelegate
@synthesize session = _session;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[SPTAuth defaultInstance] setClientID:@"17ff8b2e91e641b489c909d0d41806fe"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"callback://"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthPlaylistReadPrivateScope,SPTAuthUserLibraryReadScope,SPTAuthUserFollowReadScope]];
    [GMSServices provideAPIKey:@"AIzaSyDC4qjmzfYi0GSb0JnmYDC1XN0S7E6DokU"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {
    if ([[SPTAuth defaultInstance] canHandleURL:url]) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            [GlobalData sharedGlobalData].session = session;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"showMap" object:nil];
            if (error != nil) {
                NSLog(@"*** Auth error: %@", error);
                return;
            }
        }];
        return YES;
    }
    
    return YES;
}

@end
