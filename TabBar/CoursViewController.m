//
//  DataListViewController.m
//  TableView
//
//  Created by Jérémy Lagrue on 09/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoursViewController.h"
#import "DetailListViewController.h"
#import "CustomCell.h"
#import "ProfileViewController.h"

@interface CoursViewController ()

@end

@implementation CoursViewController

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
    [[DownloadManager shared] loadLocalFileName:@"Cours" withDelegate:self];

    self.title=@"Cours";
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView =footer;
    [super viewDidLoad];
    
  
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
    return [_arrayOfCours count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CustomCell";
    
    CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
            cell.myLabel.text = [[_arrayOfCours objectAtIndex:[indexPath row]]name];
    
    return cell;
    
}

 
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    
    
    switch (indexPath.row ) {
        case 0:   {
            ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
            [self.navigationController pushViewController:profileViewController animated:YES];
        }
            
            break;
            
        default:{   DetailListViewController *detailListViewController = [[DetailListViewController alloc] initWithNibName:@"DetailListViewController" bundle:nil];
            
            detailListViewController.texteAAfficher = [_arrayOfCours objectAtIndex:[indexPath row]];
             
            detailListViewController.title = [_dataToShow objectAtIndex:[indexPath row]];
            [self.navigationController pushViewController:detailListViewController animated:YES];
        }
            
            break;
    }
    
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
    [_arrayOfCours removeAllObjects];
    
    if (!_arrayOfCours)
        _arrayOfCours = [NSMutableArray new];
    
    // Now enumerate the json array
    for (NSDictionary *dic in object)
    {
        // Create a new contact
        Cours *c = [Cours new];
        
        // Set its properties from JSON 'object'
        c.name = [dic objectForKey:@"name"];
        c.address = [dic objectForKey:@"address"];
  
        // Add it to the array
        [_arrayOfCours addObject:c];
        
    }
  
    [self.tableView reloadData];
}
@end
