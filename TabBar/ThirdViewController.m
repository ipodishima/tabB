//
//  ThirdViewController.m
//  TabBar
//
//  Created by Marian PAUL on 21/03/12.
//  Copyright (c) 2012 IPuP SARL. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"

@interface ThirdViewController ()

@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@synthesize buttonLoginLogout = _buttonLoginLogout;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(30, 30, 280, 30)];
    [button setTitle:@"Premier controleur de la liste" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectFirstViewControllerOfListe:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setFrame:CGRectMake(30, 70, 280, 30)];
    [button2 setTitle:@"Premier controleur" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(selectFirstViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
   
    
     _buttonLoginLogout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonLoginLogout setFrame:CGRectMake(30, 150, 280, 30)];
    [_buttonLoginLogout setTitle:@"Facebook" forState:UIControlStateNormal];
    [_buttonLoginLogout addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonLoginLogout];
   [self updateView];
 
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
            }];
        }
    }

}
// FBSample logic
// main helper method to update the UI to reflect the current state of the session.

- (void)updateView {
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
    //    [self.textNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",
          //      appDelegate.session.accessToken]];
    } else {
        // login-needed account UI is shown whenever the session is closed
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
      //  [self.textNoteOrLink setText:@"Login to create a link to fetch account data"];
    }
}
- (void) selectFirstViewControllerOfListe:(id)sender 
{
    UITabBarController *tabController = self.tabBarController;
    // sélection de l'onglet le plus à gauche
    tabController.selectedIndex = 0;    
}

- (void) selectFirstViewController:(id)sender 
{
    UITabBarController *tabController = self.tabBarController;
    
    // retrouver le controleur de la classe FirstViewController
    // on parcourt le tableau des controleurs
    UIViewController *controllerToSelect = nil;
    for (UIViewController *controller in tabController.viewControllers)
        if([controller isKindOfClass:NSClassFromString(@"DataListViewController")])
        {
            controllerToSelect = controller;
            break; // on sort de la boucle
        }
    tabController.selectedViewController = controllerToSelect;    
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
 

// FBSample logic
// handler for button click, logs sessions in or out
- (IBAction)buttonClickHandler:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
             [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];
    }
}
@end
