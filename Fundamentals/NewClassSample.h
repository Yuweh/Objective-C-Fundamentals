

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
{
//add or drag ui elements here
    IBOutlet UIView *mainView;
    IBOutlet UIView *mainSubViewLayer;
    IBOutlet UILabel *headTitleLabel;
}

@end

    
    
// for .m file
    
#import "HomeViewController.h"

@implementation HomeViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainSubViewLayer.layer.cornerRadius = 5;
    mainSubViewLayer.layer.masksToBounds = true;    
}

@end
    
//to use xib file as initial viewController
    
    @AppDelegate.h
   
#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HomeViewController *homeViewConroller;

@end
    
    
    
    @AppDelegate.m
    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeViewConroller = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    //UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.homeViewConroller];
    self.window.rootViewController = self.homeViewConroller;
    [self.window makeKeyAndVisible];
    return YES;
}
    
