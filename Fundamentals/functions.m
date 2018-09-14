

- (void)updateWithInstaller:(SLInstaller *)installer {

	if (installer) {
		contactLabel.text = [self returnContactLabel:installer.contact two:NSLocalizedString(@"tahoma_view_account_account_js_contact_contact", @"")];
        emailLabel.text = [self returnContactLabel:installer.email two:NSLocalizedString(@"tahoma_view_account_account_js_notifications_email", @"")];
		phoneLabel.text = [self returnContactLabel:installer.phone two:NSLocalizedString(@"tahoma_view_account_account_js_notifications_telephone", @"")];
        companyNameLabel.text = [self returnContactLabel:installer.companyName two:NSLocalizedString(@"connexoon_installer_company_name", @"")];
        
    }
}


-(NSString*) returnContactLabel: (NSString*) installerInfo two:(NSString*)defaultLabel {
    if(([installerInfo isEqualToString:@""]) || ([installerInfo length] == 0)) return defaultLabel;
    return installerInfo;
}




