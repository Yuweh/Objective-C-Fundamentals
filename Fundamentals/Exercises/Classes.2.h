/*
Create an Objective-C class with accompanying header file. 

The class will represent a book, and should have a title, author, and a year of publication. 

Be sure to provide a designated initializer.
*/

// Book.h

@interface Book : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) int yearOfPublication;

-(instancetype)initWithTitle:(NSString*)title
                      author:(NSString*)author
                        year:(int)year;

@end

// Book.m

@implementation Book

-(instancetype)initWithTitle:(NSString*)title
                      author:(NSString*)author
                        year:(int)year {
    self = [super init];
    if(self) {
        _title = title;
        _author = author;
        _yearOfPublication = year;
    }

    return self;
}

@end


