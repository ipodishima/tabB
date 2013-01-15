//
//  DataListViewController.m
//  TableView
//
//  Created by Jérémy Lagrue on 09/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataListViewController.h"
#import "DetailListViewController.h"
#import "CustomCell.h"
#import "ProfileViewController.h"
#import "AboutViewController.h"

@interface DataListViewController ()

@end

@implementation DataListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title=@"List";
    _dataToShow = [[NSArray alloc] initWithObjects:@"Mon Profil", @"Videos", @"A propos", nil];
    _dataToDraw = [[NSArray alloc] initWithObjects: @"17-bar-chart.png",@"43-film-roll.png",@"112-group.png", nil];
   UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
   self.tableView.tableFooterView =footer;
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"CustomCell";
    
    CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
       
         UIImage *image = [UIImage imageNamed:[_dataToDraw objectAtIndex:[indexPath row]]];
    
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = image;

    cell.myLabel.text = [_dataToShow objectAtIndex:[indexPath row]];
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  //  cell.accessoryType = UITableViewCellAccessoryCheckmark;

  
    
    switch (indexPath.row ) {
        case 0:   {
                ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
                [self.navigationController pushViewController:profileViewController animated:YES];
                    }

            break;
        case 2:   {
            AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            [self.navigationController pushViewController:aboutViewController animated:YES];
        }
            
            break;
        default:{   DetailListViewController *detailListViewController = [[DetailListViewController alloc] initWithNibName:@"DetailListViewController" bundle:nil];
            
            detailListViewController.texteAAfficher = [_dataToShow objectAtIndex:[indexPath row]];
            // possibilité d'afficher un titre dans la barre de navigation
            detailListViewController.title = [_dataToShow objectAtIndex:[indexPath row]];
            [self.navigationController pushViewController:detailListViewController animated:YES];
        }

            break;
                            }
    
}

@end
