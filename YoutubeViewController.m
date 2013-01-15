//
//  YoutubeViewController.m
//  Projet
//
//  Created by Garbaya walid on 1/15/13.
//
//

#import "YoutubeViewController.h"
#import "MSToolTips/MSToolTips/YouTubeVideo.h"
@interface YoutubeViewController ()

@end

@implementation YoutubeViewController
@synthesize activityIndicator = _activityIndicator;
@synthesize nameLabel = _nameLabel;
@synthesize numberOfViewsLabel = _numberOfViewsLabel;
@synthesize numberOfVideosLabel = _numberOfVideosLabel;
@synthesize ratingLabel = _ratingLabel;
@synthesize captionTextView = _captionTextView;

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
    NSLog(@"Youtube");
    
    [[YouTubeManager shared] setYouTubeUsername:@"lepetitballoncom"];
    [[YouTubeManager shared] setDelegate:self];
    [[YouTubeManager shared] loadDataFromOffset:1];

    
    // This is one way to integrate Youtube video in your app.
    // The other is kind of a hack around UIWebView (does not work on simulator though)
    LBYouTubePlayerViewController *c = [[LBYouTubePlayerViewController alloc] initWithYouTubeID:_currentVideoDisplayed.youtubeID];
    c.quality = LBYouTubePlayerQualityLarge;
    c.view.frame = CGRectMake(60.0f, 60.0f, 200.0f, 200.0f);
    c.delegate = self;
    [self.view addSubview:c.view];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LBYouTubePlayerViewControllerDelegate

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    NSLog(@"Did extract video source:%@", videoURL);
}

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller failedExtractingYouTubeURLWithError:(NSError *)error {
    NSLog(@"Failed loading video due to error:%@", error);
}

#pragma mark - YouTubeManager delegate

- (void) youTubeManagerDidStartToLoad:(YouTubeManager *)manager
{
    [_activityIndicator startAnimating];
}

- (void) youTubeManager:(YouTubeManager *)manager didFailWithError:(NSError *)error
{
    [_activityIndicator stopAnimating];
    NSLog(@"%@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) youTubeManager:(YouTubeManager *)manager didLoadVideos:(NSArray *)videos
{
    _numberOfVideosLabel.text = [NSString stringWithFormat:@"%d videos loaded", videos.count];
    YouTubeVideo *firstVideo = [videos objectAtIndex:0];
    _nameLabel.text = firstVideo.title;
    _numberOfViewsLabel.text = [NSString stringWithFormat:@"%d views", firstVideo.nbViews];
    _ratingLabel.text = [NSString stringWithFormat:@"%f", firstVideo.rating];
    _captionTextView.text = firstVideo.caption;
    [_activityIndicator stopAnimating];
    
    _currentVideoDisplayed = firstVideo;
}

- (void)viewDidUnload
{
    [self setActivityIndicator:nil];
    [self setNameLabel:nil];
    [self setNumberOfViewsLabel:nil];
    [self setNumberOfVideosLabel:nil];
    [self setRatingLabel:nil];
    [self setCaptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
@end
