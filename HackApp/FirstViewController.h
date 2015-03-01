//
//  FirstViewController.h
//  HackApp
//
//  Created by Rohun Ati on 2/28/15.
//  Copyright (c) 2015 Rohun Ati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipeerConnectivity/MultipeerConnectivity.h"
#import "AppDelegate.h"
#import "SettingsTableViewController.h"


@interface FirstViewController : UIViewController <MCBrowserViewControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

//IBOutlets
@property (weak, nonatomic) IBOutlet UITableView *connectedDevices;
@property (weak, nonatomic) IBOutlet UIButton *disconnectOutlet;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, weak) SettingsTableViewController *settingsView;



//IBActions
- (IBAction)browseDevices:(id)sender;
- (IBAction)disconnectDevices:(id)sender;

@end

