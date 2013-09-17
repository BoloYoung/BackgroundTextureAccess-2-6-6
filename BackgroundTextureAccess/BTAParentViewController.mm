/*==============================================================================
            Copyright (c) 2011-2013 QUALCOMM Austria Research Center GmbH.
            All Rights Reserved.
            Qualcomm Confidential and Proprietary
==============================================================================*/


#import "BTAParentViewController.h"
#import "ARViewController.h"
#import "OverlayViewController.h"
#import "EAGLView.h"
#import "QCARutils.h"


@implementation BTAParentViewController // subclass of ARParentViewController

// Pass touches on to our main touchy/feely view
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Began");
    [arViewController.arView touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Moved");
    [arViewController.arView touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // let the animation complete
    [arViewController.arView touchesEnded:touches withEvent:event];
    
    UITouch* touch = [touches anyObject];
    int tc = [touch tapCount];
    NSLog(@"Ended %d", tc);
    if (2 == tc)
    {
        // Show camera control action sheet
        [[QCARutils getInstance] cameraCancelAF];
        [overlayViewController showOverlay];
    }
    if (1 == tc)
    {
        NSLog(@"Single tap");
        [[QCARutils getInstance] cameraTriggerAF];
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Cancelled");
    [arViewController.arView touchesCancelled:touches withEvent:event];
}


@end
