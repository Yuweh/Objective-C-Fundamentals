
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

//NSSTRING Referrencing

ViewController.h //Header file


@interface ViewController : UIViewController {

NSString *name;

}

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

ViewController.m //Implementation file

@interface ViewController () 

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

@end
