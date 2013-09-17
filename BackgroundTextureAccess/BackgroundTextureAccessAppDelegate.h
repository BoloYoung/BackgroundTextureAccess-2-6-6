/*==============================================================================
            Copyright (c) 2011-2013 QUALCOMM Austria Research Center GmbH.
            All Rights Reserved.
            Qualcomm Confidential and Proprietary
==============================================================================*/


#import <UIKit/UIKit.h>


@class ARParentViewController;


@interface BackgroundTextureAccessAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
    ARParentViewController* arParentViewController;
    UIImageView *splashV;
}

@end
