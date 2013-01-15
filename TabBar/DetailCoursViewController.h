//
//  DetailCoursViewController.h
//  Projet
//
//  Created by Garbaya walid on 1/14/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "Cours.h"

@interface DetailCoursViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *mapView;
    MKReverseGeocoderInternal *geoCoder;
    MKPlacemark *mPlacemark;
    CLLocationCoordinate2D location;
    UILabel *_label;
     UILabel *_labeladd;
    
}
@property (nonatomic, strong) Cours *coursAAfficher;

@end
