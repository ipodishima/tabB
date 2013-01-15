//
//  CoursViewController.h
//  Projet
//
//  Created by Élèves on 14/01/13.
//
//

#import <UIKit/UIKit.h>
#import "DownloadManager.h"
#import "Cours.h"
@interface CoursViewController : UITableViewController <DownloadDelegate>
{
    NSArray *_dataToShow;
    NSMutableArray *_arrayOfCours;

}
@end


 
 
