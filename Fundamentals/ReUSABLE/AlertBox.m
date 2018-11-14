
- (void)onDeleteRule {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"cantconnectkey", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"tahoma_common_js_cancel", @"") otherButtonTitles:NSLocalizedString(@"tahoma_common_js_ok", @""), nil];
    [alert show];      
}


- (void)noInternetAlertBox {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:NSLocalizedString(@"cantconnectkey", @"")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"") style:UIAlertActionStyleDefault
                                                          handler: nil];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
