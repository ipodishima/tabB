//
//  WineViewController.h
//  MSToolTips
//
//  Created by Marian Paul on 02/10/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface WineViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
{
    iCarousel *_carousel;
    UITextView *_textView;
}
@end
