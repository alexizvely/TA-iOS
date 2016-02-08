//
//  AboutViewController.h
//  Happy Game
//
//  Created by veli on 2/8/16.
//  Copyright © 2016 veli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AboutViewController : UIViewController <CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@end
