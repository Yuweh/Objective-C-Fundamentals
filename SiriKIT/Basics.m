

//=============================================================================
//SIRIKIT -
//=============================================================================

- (void) createNSUserActivityForSiri
{
    //シリショートカットのためNSUserActivityを作成します。|| Create NSUserActivity for Siri Shortcuts
    if (@available(iOS 12.0, *)) {
        NSUserActivity* userActivity = [[NSUserActivity alloc] initWithActivityType:@"jp.co.arkray.e-SMBG.glucoseIntent"];
        userActivity.title = @"Open %@ Glucose Level Intent";
        userActivity.eligibleForPrediction = YES;
        userActivity.userInfo = @{@"ID" : @"GlucoseLevelIntentUserInfoID"};
        userActivity.requiredUserInfoKeys = [NSSet setWithArray:userActivity.userInfo.allKeys];
        self.userActivity = userActivity; // Calls becomeCurrent/resignCurrent for us...
        
        NSLog(@"+++++ SIRIKIT: +++++ createNSUserActivityForSiri");
        [self checkIfSiriAuthorizationAllowed];
    }
}

// UserInfoがシステムによってクリアされますので、同様updateUserActivityStateメソッドを実装 || Implement the updateUserActivityState method as well since (for whatever reason) the userInfo gets cleared by the system
-(void)updateUserActivityState:(NSUserActivity *)userActivity
{
    [userActivity addUserInfoEntriesFromDictionary:@{@"ID" : @"GlucoseLevelIntentUserInfoID"}];
    NSLog(@"+++++ SIRIKIT: +++++ updateUserActivityState");
}

// Check whether you have added below Autherizaion block in your ViewController or not.
-(void)checkIfSiriAuthorizationAllowed
{
    [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
        switch (status) {
            case INSiriAuthorizationStatusAuthorized:
                NSLog(@"SIRIKIT: Authorized");
                break;
            case INSiriAuthorizationStatusDenied:
                NSLog(@"SIRIKIT: Denied");
                break;
            case INSiriAuthorizationStatusNotDetermined:
                NSLog(@"SIRIKIT: NotDetermined");
                break;
            case INSiriAuthorizationStatusRestricted:
                NSLog(@"SIRIKIT: Restricted");
                break;
        }
    }];
}

// TEMP: not yet tested if could be connected with Custom Intent || will test other code
- (void)userTriggeredAnAction
{
    if (@available(iOS 12.0, *)) {
        // Constructor intent and set parameters
        // IMPORTANT: Parameters must match one of the shortcut types that you defined in the intents definition file. Otherwise the donation with fail.
        InputGlucoseIntent* intent = [[InputGlucoseIntent alloc] init];
        
        // Set a suggested phrase (displayed when creating shortcuts)
        intent.suggestedInvocationPhrase = [NSString stringWithFormat:@"%@ %@", intent.glucoseLevel, intent.time];
        
        // Donate the interaction shortcut
        INInteraction* interaction = [[INInteraction alloc] initWithIntent:intent response:nil];
        [interaction donateInteractionWithCompletion:^(NSError * _Nullable error)
         {
             if (error)
             {
                 NSLog(@"Failed to donate interaction: %@ ", [error localizedDescription] );
             }
         }];
    }
}



