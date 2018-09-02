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
@property (weak, nonatomic) IBOutlet UILabel *label;
@end   
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
@property (weak, nonatomic) IBOutlet UILabel *label;
@end   
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
@property (weak, nonatomic) IBOutlet UILabel *label;
@end   
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
//NSARRAY Referrencing and used a Label
ViewController.h //Header file
@interface ViewController : UIViewController {
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@end   
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
   NSArray *arraySample = @[@"Apple", @"Banana", @"Orange"];
   self.label.text = array[2]; //will display Orange
    
    //will create a mutable or changeable array
    NSMutableArray *array2 = [[NSMutableArray alloc] iniwWithObjects:@"Apple",@"Banana", @"Orange", nil];
    //insert new object
    [array2 addObject:@"Melon"];
    //replace object
    [array2 addObject:@"Strawberry" atIndex:3];
    //remove object
    [array2 removeObjectatIndex:3];
    //set it with the 2nd label
    self.label2.text = array2;
    //count the array
    self.label2.text =  [NSString stringWithFormat:@"%lu", array2.count];
}
@end
        
-----------------------------------------------------------------------------------------------------
// Working with IF, ELSE, or STATMENTS in ObjC, with 5 labels;
ViewController.h //Header file
@interface ViewController : UIViewController {
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@end;
- - -
ViewController.m //Implementation file
@interface ViewController () 
@end
@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //IF
   BOOL state = false;
   if (state == true) {
       self.label1.text = @"Allow Access";
   } else {
        self.label1.text = @"Deny Access";
   }
     
    //ELSE IF
    NSString *name = @"Xian";
    
    if ([name isEqualToString:@"Xian"]) {
        self.label2.text = @"Grant Access";
    } else if ([name isEqualToString:@"Admin"]) {
        self.label2.text = @"Ask Password";
    } else {
        self.label2.text = @"Ask Password and Identity";
    }
    
    // < less than OR greater than > IF condition
    int number = 400;
    if (number > 500) {
        self.label3.text = @"Unlock level 2";
    } else {
        self.label3.text = @"Retry";
    }
    // OR
    NSString *colour = @"Green";
    if ([colour isEqualtoString:@"Green"] || [colour isEqualtoString:@"Blue"]) {
        self.label4.text = @"Good colour";  
    }
    
    // AND &
    NSString *username = @"RedKitty123";
    NSString *password = @"Apple123";
    
    if ([username isEqualToString:@"RedKitty123"] && [username isEqualToString:@"Apple123"]){
        self.label5.text = @"Grant access"; 
    } else if ([username isEqualToString:@"RedKitty123"]) {
        self.label5.text = @"Password incorrect"; 
    } else if ([username isEqualToString:@"Apple123"]) {
        self.label5.text = @"Username incorrect";
    } else {
        self.label5.text = @"Both incorrect";
    }
}
@end
-----------------------------------------------------------------------------------------------------
// LOOP
ViewController.h //Header file
@interface ViewController : UIViewController {
    int number = 10;
    for (number = 10; number > 0; number -= 1) {
        NSLog(@%i%, number);
    }
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
