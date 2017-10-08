//
//  ViewController.m
//  Hello Objective-C!
//
//  Created by Francis Jemuel Bergonia on 04/10/2017.
//  Copyright © 2017 Francis Jemuel Bergonia. All rights reserved.
//

#import "ViewController.h" //important //should always be there to access things

@interface ViewController()
@property (nonatomic, strong) NSString *vehicle; //if you don't want a property publicly available you define them here
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Name: %@",self.name);
    //the @"Name: %@" is said to be like string interpolation in Swift
    self.name = @"Jack";
    NSLog(@"Name: %@", self.name);
    _name = @"Peter"; //the _name is a property / it's under property and serves like an instance and you could answer it by having it use underscore
    NSLog(@"Name: %@", _name);
    [self setName:@"Sylvia"];
    NSLog(@"Name: %@", [self name]);
    // the ff,.above are a few ways to create property and access it's propertis using the ff. methods
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBait:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WELCOME" message:@"Welcome to the World of Objective-C" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"CLOSE" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:closeAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
