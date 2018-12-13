
//In Xcode 9.4.1
//Create alert function globally and use every ware.

//Alert function
- (void) showAlertMsg:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message {

    UIAlertController * alert = [UIAlertController alertControllerWithTitle : title
                                                                    message : message
                                                             preferredStyle : UIAlertControllerStyleAlert];

    UIAlertAction * ok = [UIAlertAction
                          actionWithTitle:@"OK"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          { }];

    [alert addAction:ok];
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:alert animated:YES completion:nil];
    });

}

//Call like this in your required place.
//Import that class and create instance

//Ex:
GlobalClassViewController *gcvc = [[GlobalClassViewController alloc]init];

//Call alert function with instance
[gcvc showAlertMsg:self title:@"" message:placeholderText];

