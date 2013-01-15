//
//  WineViewController.m
//  MSToolTips
//
//  Created by Marian Paul on 02/10/12.
//  Modified by wgarbaya
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import "WineViewController.h"
#import "Wine.h"
#import "DetailWineViewController.h"
#import "SDWebImage/SDWebImage/UIImageView+WebCache.h"
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
     [[DownloadManager shared] loadLocalFileName:@"vin" withDelegate:self];
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.title = @"Vins";
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
       
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 180, 280, 30)];
    [button setTitle:@"Details" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectDetailWineController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void) selectDetailWineController:(id)sender
{
    Wine *w = [_arrayOfWine objectAtIndex:_carousel.currentItemIndex];
      NSLog(@"%@", w.name);
    DetailWineViewController *detailWineViewController =[[DetailWineViewController alloc] initWithNibName:@"DetailWineViewController" bundle:nil];
    detailWineViewController.texteAAfficher = w.apropos;
    detailWineViewController.wineAAfficher = w;
    detailWineViewController.title = w.name;
    [self.navigationController pushViewController:detailWineViewController animated:YES];
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
     [_arrayOfWine removeAllObjects];
 
    if (!_arrayOfWine)
        _arrayOfWine = [NSMutableArray new];
    
    // Now enumerate the json array
    for (NSDictionary *dic in object)
    {
        // Create a new contact
        Wine *w = [Wine new];
        
        // Set its properties from JSON 'object'
        w.name = [dic objectForKey:@"name"];
        w.domaine = [dic objectForKey:@"domaine"];
        w.apropos = [dic objectForKey:@"apropos"];
        w.age = [dic objectForKey:@"age"]  ;
        w.image = [dic objectForKey:@"image"]  ;
        w.nombre = 1;
        // Add it to the array
        [_arrayOfWine addObject:w];
        
    }
    [_carousel reloadData];
    Wine *w = [_arrayOfWine objectAtIndex:_carousel.currentItemIndex];
    _textView.text = [NSString stringWithFormat:@"%s",[w.apropos UTF8String ]];
    
 
    
      } 
#pragma mark - iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _arrayOfWine.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        if([_arrayOfWine count ] != 0){
            Wine *w = [_arrayOfWine objectAtIndex:index];
           
            if ([w.image length] != 0) {
                UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
                [imageView setImageWithURL:[NSURL URLWithString:w.image]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                view = imageView;
            } else {
                  view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mabout.png.png"]];
            }
           

        }
        else {
            
                view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mabout.png.png"]];
             
        }
    }

    
      
    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 90.0; /*image width*/
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel;
{
    if([_arrayOfWine count ] != 0){
         Wine *w = [_arrayOfWine objectAtIndex:carousel.currentItemIndex];
        _textView.text = [NSString stringWithFormat:@"%s",[w.apropos UTF8String]];
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