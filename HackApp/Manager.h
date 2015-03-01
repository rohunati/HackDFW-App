//
//  Manager.h
//  HackApp
//
//  Created by Rohun Ati on 3/1/15.
//  Copyright (c) 2015 Rohun Ati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultipeerConnectivity/MultipeerConnectivity.h"

@interface Manager : NSObject <MCSessionDelegate>

@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCBrowserViewController *browser;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;

-(void)setupPeerAndSessionWithDisplayName:(NSString *)displayName;
-(void)setupMCBrowser;
-(void)advertiseSelf:(BOOL)shouldAdvertise;

@end
