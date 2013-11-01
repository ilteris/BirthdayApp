//
//  BDAViewController.m
//  BirthdayApp
//
//  Created by ilteris on 10/31/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "BDALoginViewController.h"
#import <Parse/Parse.h>
#import "BDAListViewController.h"


@interface BDALoginViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation BDALoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_activityIndicator stopAnimating];
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        BDAListViewController* listViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BDAListViewController"];
        
        [[self navigationController] pushViewController:listViewController animated:YES];
    }
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Login mehtods

/* Login to facebook method */
- (IBAction)loginButtonTouchHandler:(id)sender  {
   
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"BDAListViewController"]) {
        //prepare any data here.
        NSLog(@"preparing to launch list controller");
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
