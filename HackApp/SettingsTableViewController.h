//
//  SettingsTableViewController.h
//  HackApp
//
//  Created by Rohun Ati on 3/1/15.
//  Copyright (c) 2015 Rohun Ati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipeerConnectivity/MultipeerConnectivity.h"
#import "AppDelegate.h"

@interface SettingsTableViewController : UITableViewController <UITextFieldDelegate>

//IBOutlets
@property (weak, nonatomic) IBOutlet UISwitch *switchVisible;
@property (weak, nonatomic) IBOutlet UITextField *displayTitle;
@property (nonatomic, strong) AppDelegate *appDelegate;


//IBActions
- (IBAction)toggleVisibility:(id)sender;

@end
