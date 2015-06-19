//
//  ViewController.m
//  Stadium
//
//  Created by Mani Kishore Chitrala on 6/18/15.
//  Copyright (c) 2015 Mani Kishore Chitrala. All rights reserved.
//


#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithFacebook:(id)sender {
    [PFFacebookUtils logInInBackgroundWithReadPermissions:[NSArray arrayWithObject:@"user_friends"] block:^(PFUser *user, NSError *error){
        if (!user) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        }

    }];

}
@end
