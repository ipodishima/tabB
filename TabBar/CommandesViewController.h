//
//  CommandesViewController.h
//  Projet
//
//  Created by Élèves on 14/01/13.
//
//

#import <UIKit/UIKit.h>
#import "DetailListViewController.h"
#import "CustomCell.h"
#import "AppDelegate.h"
#import "Wine.h"
#import "WineCell.h"
@interface CommandesViewController : UITableViewController
{

    NSArray *_dataToShow;
    NSArray *_dataToDraw;
     UITableView *tableView;
}
@property (strong, nonatomic) NSMutableArray *arrayOfWineToOrder;
@property (strong, nonatomic) NSMutableDictionary *postParams;
@end
