/*==============================================================================
            Copyright (c) 2011-2013 QUALCOMM Austria Research Center GmbH.
            All Rights Reserved.
            Qualcomm Confidential and Proprietary
==============================================================================*/
/*
 
 The QCAR sample apps are organised to work with standard iOS view
 controller life cycles.
 
 * QCARutils contains all the code that initialises and manages the QCAR
 lifecycle plus some useful functions for accessing targets etc. This is a
 singleton class that makes QCAR accessible from anywhere within the app.
 
 * AR_EAGLView is a superclass that contains the OpenGL setup for its
 sub-class, EAGLView.
 
 Other classes and view hierarchy exists to establish a robust view life
 cycle:
 
 * ARParentViewController provides a root view for inclusion in other view
 hierarchies  presentModalViewController can present this VC safely. All
 associated views are included within it; it also handles the auto-rotate
 and resizing of the sub-views.
 
 * ARViewController manages the lifecycle of the Camera and Augmentations,
 calling QCAR:createAR, QCAR:destroyAR, QCAR:pauseAR and QCAR:resumeAR
 where required. It also manages the data for the view, such as loading
 textures.
 
 This configuration has been shown to work for iOS Modal and Tabbed views.
 It provides a model for re-usability where you want to produce a
 number of applications sharing code.
 
 The BackgroundTextureAccess app creates subclasses of some of the ARCommon classes
 in the following manner:
 
 * BTAParentViewController extends ARParentViewController by handling touch events
 and passing them to the EAGLView class.
 
 --------------------------------------------------------------------------------*/


#import "BackgroundTextureAccessAppDelegate.h"
#import "BTAParentViewController.h"
#import "QCARutils.h"


namespace {
    BOOL firstTime = YES;
}

@implementation BackgroundTextureAccessAppDelegate

// this is the application entry point
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc] initWithFrame: screenBounds];
    
    // Provide a list of targets we're expecting - the first in the list is the default
    [[QCARutils getInstance] addTargetName:@"Tarmac" atPath:@"Tarmac.xml"];
    
    // Add the EAGLView and the overlay view to the window
    arParentViewController = [[BTAParentViewController alloc] initWithWindow:window];
    arParentViewController.arViewRect = screenBounds;
    [window setRootViewController:arParentViewController];
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // don't do this straight after startup - the view controller will do it
    if (firstTime == NO)
    {
        // do the same as when the view is shown
        [arParentViewController viewDidAppear:NO];
    }
    
    firstTime = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // do the same as when the view has dissappeared
    [arParentViewController viewDidDisappear:NO];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // AR-specific actions
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Handle any background procedures not related to animation here.
    
    // Inform the AR parent view controller that the AR view should free any
    // easily recreated OpenGL ES resources
    [arParentViewController freeOpenGLESResources];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Handle any foreground procedures not related to animation here.
}

- (void)dealloc
{
    [arParentViewController release];
    [window release];
    
    [super dealloc];
}

@end
