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
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, CGRectGetWidth(self.view.bounds)-10.0, 15.0)];
    _label.text = [NSString stringWithFormat:@"Nom: %s",[_wineAAfficher.name UTF8String ]];
   [self.view addSubview:_label];
    
    _labelage = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 15.0, CGRectGetWidth(self.view.bounds)-10.0, 30.0)];
     _labelage.text = [NSString stringWithFormat:@"Date: %s",[_wineAAfficher.age UTF8String ]];
     [self.view addSubview:_labelage];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 45.0, CGRectGetWidth(self.view.bounds)-10.0, 150.0)];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont boldSystemFontOfSize:15.0];
    _textView.backgroundColor = [UIColor grayColor];
    _textView.editable = false;
    _textView.text = [NSString stringWithFormat:@"%s",[_wineAAfficher.apropos UTF8String ]];
    [self.view addSubview:_textView];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
