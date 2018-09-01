//STRING variable
NSString *word1 = @"Hello";
//string constant
NSString * const word2 = @"Goodbye";
//assign new values to a variable
wor1 = @"Hello Maggie"; //word1 is now changed, from Hello to Hello Maggie
-----------------------------------------------------------------------------------------------------
//INT variable
int int1 = 10;
//int constant
const int int2 = 20;
-----------------------------------------------------------------------------------------------------
//NSSTRING Referrencing and used a Label
ViewController.h //Header file
@interface ViewController : UIViewController {
//variable set
NSString *nameOfAPerson;

}
@property (weak, nonatomic) IBOutlet UILabel *label;
@end   
----------------------------------------------
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
   //variable modified
    nameOfAPerson = @"Xian Jae";
    
   //locally set variable @m
    NSString *word = @"Bergonia";
            
   //the created label and had referrence @the Header file will now be using the variable we have modified
    self.label.text = name;   
    
    //string concatenation - > displays Xian Jae Bergonia :D
     self.label.text = [NSString stringWithFormat:@"%@ %@", nameOfAPerson, word];
}
@end
-----------------------------------------------------------------------------------------------------
//INT Referrencing and used a Label
ViewController.h //Header file
@interface ViewController : UIViewController {
//Set 2 integers here @.h
    int intNumber1;
    int intNumber2;
}
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
    //use 2 integers earlier and set values
    intNumber1 = 10;
    intNumber2 = 100;
    int score = intNumber1 + intNumber2; // -> equals 110
    int score = intNumber1 * intNumber2; // -> equals 1000
    //%d an INT inside a string & labels shows 110
     self.label.text = [NSString stringWithFormat:@"%d", score];
}
@end
-----------------------------------------------------------------------------------------------------
//DOUBLE Referrencing and used a Label
ViewController.h //Header file
@interface ViewController : UIViewController {
//Set 2  double values here @.h
    double double1;
    double double2;
}
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
   //use double numbers above
    double1 = 100.343;
    double2 = 213.324;
    double score = double 1 + double2;
    //"%.3f" and the number represents how many numbers you want to show after the decimal point
     self.label.text = [NSString stringWithFormat:@"%.3f", score];
}
@end
-----------------------------------------------------------------------------------------------------
//BOOLEAN Referrencing and used a BUTTON and SWITCH
ViewController.h //Header file
@interface ViewController : UIViewController {
    //Set BOOL values 
    BOOL bool1;
    BOOL bool2;
}
//Set UIButton and UISwitch Outlets
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@end
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
   //change BOOL values
    bool1 = YES;
    bool2 = false;
    self.mySwitch.on = bool1;
    self.button.enabled = bool2;
    // switch is now ON and button is not enabled.
}
@end
        
-----------------------------------------------------------------------------------------------------
//NSARRAY Referrencing and used a BUTTON and SWITCH
ViewController.h //Header file
@interface ViewController : UIViewController {
}
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
   NSArray *arraySample = @[@"Apple", @"Banana"];
}
@end
        
-----------------------------------------------------------------------------------------------------

ViewController.h //Header file
@interface ViewController : UIViewController {



}
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
   
}
@end
