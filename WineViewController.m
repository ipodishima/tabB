//
//  WineViewController.m
//  MSToolTips
//
//  Created by Marian Paul on 02/10/12.
//  Modified by wgarbaya
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import "WineViewController.h"
#import "Contact.h"
@interface WineOverlayView : UIView

@end

@interface WineViewController ()
{
    WineOverlayView *_overlay;
}
@end

@implementation WineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     [[DownloadManager shared] loadLocalFileName:@"SampleLoad" withDelegate:self];
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.title = @"Wine";
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 270.0, CGRectGetWidth(self.view.bounds), 111.0 /*depends strongly of values in overlay*/)];
    // these values in initWithFrame should be fixed, having hardcoded values is not great!
   
  _carousel.type = iCarouselTypeRotary; // Try other values to see what happens
    _carousel.type = iCarouselTypeCoverFlow;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.clipsToBounds = NO;
     _carousel.userInteractionEnabled = YES;
    [self.view addSubview:_carousel];
    
    _overlay = [[WineOverlayView alloc] initWithFrame:self.view.bounds];
    _overlay.userInteractionEnabled = NO;
    [self.view addSubview:_overlay];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 10.0, CGRectGetWidth(self.view.bounds)-10.0, 150.0)];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont boldSystemFontOfSize:15.0];
    _textView.editable = false;
    [self.view addSubview:_textView];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - DownloadDelegate protocol

- (void) downloadOperation:(DownloadOperation *)operation didFailWithError:(NSError *)error
{
    // Stop activity indicator
    NSLog(@"%@", error);
    // Todo : handle the error
}

- (void) downloadOperation:(DownloadOperation *)operation didStartLoadingRequest:(NSMutableURLRequest *)request
{
}

- (void) downloadOperation:(DownloadOperation *)operation didLoadObject:(id)object
{
     [_arrayOfContacts removeAllObjects];
 
    if (!_arrayOfContacts)
        _arrayOfContacts = [NSMutableArray new];
    
    // Now enumerate the json array
    for (NSDictionary *dic in object)
    {
        // Create a new contact
        Contact *c = [Contact new];
        
        // Set its properties from JSON 'object'
        c.firstName = [dic objectForKey:@"FirstName"];
        c.lastName = [dic objectForKey:@"LastName"];
        c.job = [dic objectForKey:@"Job"];
        c.age = [[dic objectForKey:@"Age"] integerValue];
        // Add it to the array
        [_arrayOfContacts addObject:c];
        
    }
    
    // Try these
    // [_arrayOfContacts sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES]]];
    // [_arrayOfContacts sortUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES]]];
    // Pretty cool no?
    
    // We are almost done. Please note that the parsing is made here just to avoid complexification. You should always create a model like YouTubeManager class which handles the parsing and give the data to the controller. Remember the MVC pattern
    
      } 
#pragma mark - iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 10 /*This is where you will set count values from server response*/;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
    
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bouteille.png"]];
        if (index == 0)
        {
            view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mabout.png.png"]];
        }
    }

    
    // Use for example SDWebImageView to load the image from internet in an asynchronous way
    
    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 90.0; /*image width*/
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel;
{
    if(_arrayOfContacts.count !='O'){
         Contact *c = [_arrayOfContacts objectAtIndex:carousel.currentItemIndex];
        _textView.text = [NSString stringWithFormat:@"This is where you should place the text from the bottle. Current index is %d %s", carousel.currentItemIndex,[c.firstName UTF8String]];
    }
    
}

@end


@implementation WineOverlayView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    // Get the context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Build the path with triangle
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, 0.0, 250.0);
    CGContextAddLineToPoint(context, 140.0, 250.0);
    CGContextAddLineToPoint(context, 160.0, 270.0);
    CGContextAddLineToPoint(context, 180.0, 250.0);
    CGContextAddLineToPoint(context, 320.0, 250.0);
    CGContextAddLineToPoint(context, 320.0, 0.0);
    
    // Close it
    CGContextClosePath(context);
    // Set fill color with white
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    // Add some shadows
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 2.0), 5.0, [UIColor blackColor].CGColor);
    // Fill the path
    CGContextFillPath(context);
}
 

@end