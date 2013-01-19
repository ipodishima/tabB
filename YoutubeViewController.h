//
//  YoutubeViewController.h
//  Projet
//
//  Created by Garbaya walid on 1/15/13.
//
//
 
#import <UIKit/UIKit.h>
#import "MSToolTips/MSToolTips/YouTubeManager.h"
#import "LBYouTubePlayerViewController.h"
@class YouTubeVideo;
@interface YoutubeViewController : UIViewController<YouTubeManagerDelegate, LBYouTubePlayerControllerDelegate>{
     YouTubeVideo *_currentVideoDisplayed;
    LBYouTubePlayerViewController *_currentVideoController;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfViewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfVideosLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@end
 

 

 