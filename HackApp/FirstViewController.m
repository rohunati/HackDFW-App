//
//  FirstViewController.m
//  HackApp
//
//  Created by Rohun Ati on 2/28/15.
//  Copyright (c) 2015 Rohun Ati. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController () 

@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[_appDelegate manager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
    
     _arrConnectedDevices = [[NSMutableArray alloc] init];
    
    [_connectedDevices setDelegate:self];
    [_connectedDevices setDataSource:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [_appDelegate.manager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.manager.browser dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)browseDevices:(id)sender {
    
    [[_appDelegate manager] setupMCBrowser];
    [[[_appDelegate manager] browser] setDelegate:self];
    [self presentViewController:[[_appDelegate manager] browser] animated:YES completion:nil];
}

- (IBAction)disconnectDevices:(id)sender {
    
    [_appDelegate.manager.session disconnect];
    
    [_settingsView displayTitle].enabled = YES;
    
    [_arrConnectedDevices removeAllObjects];
    [_connectedDevices reloadData];
}

#pragma mark - Pivate method implementation

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
        if (state == MCSessionStateConnected) {
            [_arrConnectedDevices addObject:peerDisplayName];
        }
        else if (state == MCSessionStateNotConnected){
            if ([_arrConnectedDevices count] > 0) {
                int indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
                [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
                
                [_connectedDevices reloadData];
                
                BOOL peersExist = ([[_appDelegate.manager.session connectedPeers] count] == 0);
                [_disconnectOutlet setEnabled:!peersExist];
                [[_settingsView displayTitle] setEnabled:peersExist];
            }
        }
    }
}

#pragma mark - UITableView Delegate and Datasource method implementation
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrConnectedDevices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = [_arrConnectedDevices objectAtIndex:indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
@end
