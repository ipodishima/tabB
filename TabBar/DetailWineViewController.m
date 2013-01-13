//
//  DetailWineViewController.m
//  Projet
//
//  Created by Garbaya walid on 12/31/12.
//
//

#import "DetailWineViewController.h"

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
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 3, CGRectGetWidth(self.view.bounds)-10.0, 15.0)];
    _label.text = [NSString stringWithFormat:@"Nom: %s",[_wineAAfficher.name UTF8String ]];
   [self.view addSubview:_label];
    
    _labelage = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 21.0, CGRectGetWidth(self.view.bounds)-10.0, 15.0)];
     _labelage.text = [NSString stringWithFormat:@"Date: %s",[_wineAAfficher.age UTF8String ]];
     [self.view addSubview:_labelage];
    _labeldom = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 39.0, CGRectGetWidth(self.view.bounds)-10.0, 15.0)];
    _labeldom.text = [NSString stringWithFormat:@"Domaine: %s",[_wineAAfficher.domaine UTF8String ]];
    [self.view addSubview:_labeldom];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 57.0, CGRectGetWidth(self.view.bounds)-20.0, 150.0)];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont boldSystemFontOfSize:15.0];
    _textView.backgroundColor = [UIColor grayColor];
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
{ UITabBarController *tabController = self.tabBarController;
  
    UIViewController *controllerToSelect = nil;
    for (UIViewController *controller in tabController.viewControllers)
        if([controller isKindOfClass:NSClassFromString(@"ThirdViewController")])
        {
            controllerToSelect = controller;
            break; 
        }
    
  
    
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
