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
 
    [self.view addSubview:_label];

    _labeladd = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 21, CGRectGetWidth(self.view.bounds)-20.0, 15.0)];
    _labeladd.text = [NSString stringWithFormat:@"Addresse: %s",[_coursAAfficher.address UTF8String ]];
 
    [self.view addSubview:_labeladd];
    
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10.0, 45, CGRectGetWidth(self.view.bounds)-20.0, 150)];
    [mapView setShowsUserLocation:TRUE];
    [mapView setMapType:MKMapTypeStandard];
    [self.view addSubview:mapView];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude =  _coursAAfficher.lat;
  
    annotationCoord.longitude = _coursAAfficher.lon;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = _coursAAfficher.name;
   
    [mapView addAnnotation:annotationPoint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end