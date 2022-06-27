//
//  UpdateWindowController.m
//  ReiKey
//
//  Created by Patrick Wardle on 12/24/18.
//  Copyright © 2018 Objective-See. All rights reserved.
//

#import "consts.h"
#import "utilities.h"
#import "AppDelegate.h"
#import "UpdateWindowController.h"

@implementation UpdateWindowController

@synthesize infoLabel;
@synthesize overlayView;
@synthesize actionButton;
@synthesize infoLabelString;
@synthesize actionButtonTitle;
@synthesize progressIndicator;

//automatically called when nib is loaded
// ->center window
-(void)awakeFromNib
{
    //center
    [self.window center];
    
    return;
}

//automatically invoked when window is loaded
-(void)windowDidLoad
{
    //super
    [super windowDidLoad];
    
    //not in dark mode?
    // make window white
    if(YES != isDarkMode())
    {
        //make white
        self.window.backgroundColor = NSColor.whiteColor;
    }
    
    //indicated title bar is tranparent (too)
    self.window.titlebarAppearsTransparent = YES;
    
    //set main label
    [self.infoLabel setStringValue:self.infoLabelString];
    
    //set button text
    self.actionButton.title = self.actionButtonTitle;

    //make it key window
    [self.window makeKeyAndOrderFront:self];
    
    //make window front
    [NSApp activateIgnoringOtherApps:YES];
    
    //button first responder
    [self.window makeFirstResponder:self.actionButton];
    
    return;
}

//automatically invoked when window is closing
// ->make ourselves unmodal
-(void)windowWillClose:(NSNotification *)notification
{
    //make un-modal
    [[NSApplication sharedApplication] stopModal];
    
    return;
}

//save the main label's & button title's text
// ->invoked before window is loaded (and thus buttons, etc are nil)
-(void)configure:(NSString*)label buttonTitle:(NSString*)buttonTitle
{
    //save label's string
    self.infoLabelString = label;
    
    //save button's title
    self.actionButtonTitle = buttonTitle;
    
    return;
}

//invoked when user clicks button
// trigger action such as opening product website, updating, etc
-(IBAction)buttonHandler:(id)sender
{
    //handle 'update' / 'more info', etc
    // open product webpage, if they *didn't* click 'Close'
    if(YES != [((NSButton*)sender).title isEqualToString:@"Close"])
    {
        //open URL
        // invokes user's default browser
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:PRODUCT_URL]];
    }
    
    //always close window
    [[self window] close];
        
    return;
}

@end
