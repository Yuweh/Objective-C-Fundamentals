
//Code for the House Class
//Here is the code we've written so far for the House class:
//House.h

#import ""

@interface House : NSObject 

@property (nonatomic) NSString *address;
@property (nonatomic) int numberOfBedrooms;
@property (nonatomic) bool hasHotTub;

@end

/*

Property attributes: Nonatomic/Atomic
Let's think some more about what to put in between the parentheses after @property.

What does nonatomic mean? Nonatomic is a property attribute. 
Properties can be either atomic or nonatomic; this distinction relates to how properties are handled in multithreading. 
It is beyond the scope of this course to get into the specifics of the difference, 
but the vast majority of properties you will use will be nonatomic. 

The default is atomic, so you need to write “nonatomic” almost every time you declare a property

PRO TIP: 

Atomic means only one thread accesses the variable (static type). 
Atomic is thread-safe, but it is slow. 

Nonatomic means multiple threads access the variable (dynamic type). 
Nonatomic is thread-unsafe, but it is fast.

*/




