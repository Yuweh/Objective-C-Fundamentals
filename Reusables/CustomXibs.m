//reference: https://medium.com/@brianclouser/creating-a-custom-view-using-a-xib-in-objective-c-6041140a16ca

@interface GlucAveMenuVC () {

}
@end


@implementation GlucAveMenuVC

//--------------------------------------------------------------------------
- (void)initCommonUnique
{
    //Load xib file
    NSString *className = NSStringFromClass([self class]);
    [[NSBundle bundleForClass:[self class]] loadNibNamed:className
                                                   owner:self
                                                 options:nil];
    self.view.frame = self.bounds; //Size on initWithFrame or xib
    [self addSubview: self.view];
    
}

- (void)initCommon
{
    [self initCommonUnique];
    [self updateGlucoseMenuLabels];
}
//--------------------------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
//--------------------------------------------------------------------------
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
//--------------------------------------------------------------------------
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCommon];
    }
    return self;
}




