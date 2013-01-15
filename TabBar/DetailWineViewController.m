//
//  DetailWineViewController.m
//  Projet
//
//  Created by Garbaya walid on 12/31/12.
//
//

#import "DetailWineViewController.h"
#import "CommandesViewController.h"

@interface DetailWineViewController ()

@end

@implementation DetailWineViewController
@synthesize texteAAfficher = _texteAAfficher;
@synthesize wineAAfficher = _wineAAfficher;


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
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 3, CGRectGetWidth(self.view.bounds)-20.0, 15.0)];
    _label.text = [NSString stringWithFormat:@"Nom: %s",[_wineAAfficher.name UTF8String ]];
    _label.backgroundColor =[UIColor colorWithRed:204.00/255.0 green:1.0 blue:1.0 alpha:0.4];
   [self.view addSubview:_label];
    
    _labelage = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 21.0, CGRectGetWidth(self.view.bounds)-20.0, 15.0)];
     _labelage.text = [NSString stringWithFormat:@"Date: %s",[_wineAAfficher.age UTF8String ]];
    _labelage.backgroundColor =[UIColor colorWithRed:204.00/255.0 green:1.0 blue:1.0 alpha:0.4];
     [self.view addSubview:_labelage];
    _labeldom = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 39.0, CGRectGetWidth(self.view.bounds)-20.0, 15.0)];
    _labeldom.text = [NSString stringWithFormat:@"Domaine: %s",[_wineAAfficher.domaine UTF8String ]];
    _labeldom.backgroundColor =[UIColor colorWithRed:204.00/255.0 green:1.0 blue:1.0 alpha:0.4];
    [self.view addSubview:_labeldom];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 57.0, CGRectGetWidth(self.view.bounds)-20.0, 150.0)];
    _textView.textColor = [UIColor blackColor];
 
    _textView.font = [UIFont boldSystemFontOfSize:15.0];
    _textView.backgroundColor = [UIColor colorWithRed:204.00/255.0 green:1.0 blue:1.0 alpha:0.4];
     
    _textView.editable = false;
    _textView.text = [NSString stringWithFormat:@"%s",[_wineAAfficher.apropos UTF8String ]];
    [self.view addSubview:_textView];
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(10.0, 230.0, 100, 100)];
    [imageView setImageWithURL:[NSURL URLWithString:_wineAAfficher.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.view addSubview:imageView];
 
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setFrame:CGRectMake(120, 240, 100, 30)];
    [button2 setTitle:@"Commander" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(commander:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void) commander:(id)sender
{
    UITabBarController *tabController = self.tabBarController;
     
    CommandesViewController *controllerToSelect = nil;
    for (UIViewController *controller in tabController.viewControllers)
        if([controller isKindOfClass:NSClassFromString(@"CommandesViewController")])
        {
            controllerToSelect =(id) controller;
            
            break; 
        }
    if (controllerToSelect.arrayOfWineToOrder == nil) {
    controllerToSelect.arrayOfWineToOrder = [NSMutableArray  arrayWithObjects:nil];
    }
 
    if (controllerToSelect.arrayOfWineToOrder.count == 0) {
        _wineAAfficher.nombre = 1;
        [controllerToSelect.arrayOfWineToOrder  addObject:_wineAAfficher];

    } else {
        for (int y =0 ; y <= controllerToSelect.arrayOfWineToOrder.count; y++) {
            Wine *wine = [controllerToSelect.arrayOfWineToOrder objectAtIndex:y ];
            if (wine.name = _wineAAfficher.name)
            {
                wine.nombre++;
               
                break;
            }
        
        }

    }
       
 
  [controllerToSelect.tableView reloadData];
  
    NSInteger theInteger = [controllerToSelect.tabBarItem.badgeValue integerValue];
    theInteger++;
   [[controllerToSelect tabBarItem]setBadgeValue:[NSString stringWithFormat:@"%d", theInteger]];
 
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

@end
