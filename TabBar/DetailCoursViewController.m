//
//  DetailCoursViewController.m
//  Projet
//
//  Created by Garbaya walid on 1/14/13.
//
//

#import "DetailCoursViewController.h"

@interface DetailCoursViewController ()

@end

@implementation DetailCoursViewController
@synthesize coursAAfficher = _coursAAfficher;
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
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 3, CGRectGetWidth(self.view.bounds)-20.0, 15.0)];
    _label.text = [NSString stringWithFormat:@"Cours: %s",[_coursAAfficher.name UTF8String ]];
    _label.backgroundColor =[UIColor colorWithRed:204.00/255.0 green:1.0 blue:1.0 alpha:0.4];
    [self.view addSubview:_label];

    
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10.0, 25, CGRectGetWidth(self.view.bounds)-20.0, 150)];
    [mapView setShowsUserLocation:TRUE];
    [mapView setMapType:MKMapTypeStandard];
    [self.view addSubview:mapView];
    
   // CLLocationManager *locationManager = [[CLLocationManager alloc]init];
   //> [locationManager setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end