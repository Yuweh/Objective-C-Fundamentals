//
//  ViewController.h
//  Hello Objective-C!
//
//  Created by Francis Jemuel Bergonia on 04/10/2017.
//  Copyright © 2017 Francis Jemuel Bergonia. All rights reserved.
//


#import <UIKit/UIKit.h> //imports the UIKIT classes and properties, including UIViewController

@interface ViewController : UIViewController //this where your class name is named and inherits properties from UIViewController

@property (nonatomic, strong) NSString *name; //anything in between @interface and @end which are placed ViewController.Header will be publicly available
//the @property above could be accessed at ViewController.m

@end


