//
//  WineViewController.m
//  MSToolTips
//
//  Created by Marian Paul on 02/10/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import "WineViewController.h"

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
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 300.0, CGRectGetWidth(self.view.bounds), 111.0 /*depends strongly of values in overlay*/)];
    // these values in initWithFrame should be fixed, having hardcoded values is not great!
   
  //_carousel.type = iCarouselTypeRotary; // Try other values to see what happens
    _carousel.type = iCarouselTypeCoverFlow;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.clipsToBounds = NO;
    _carousel.userInteractionEnabled = YES;
    [self.view addSubview:_carousel];
    
    _overlay = [[WineOverlayView alloc] initWithFrame:self.view.bounds];
    _overlay.userInteractionEnabled = NO;
    [self.view addSubview:_overlay];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 10.0, 300.0, 280.0)];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont boldSystemFontOfSize:15.0];
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
    _textView.text = [NSString stringWithFormat:@"This is where you should place the text from the bottle. Current index is %d", carousel.currentItemIndex];
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
    CGContextAddLineToPoint(context, 0.0, 300.0);
    CGContextAddLineToPoint(context, 140.0, 300.0);
    CGContextAddLineToPoint(context, 160.0, 320.0);
    CGContextAddLineToPoint(context, 180.0, 300.0);
    CGContextAddLineToPoint(context, 320.0, 300.0);
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