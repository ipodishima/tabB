#import "CommandesViewController.h"



@interface CommandesViewController ()
@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
@property (strong, nonatomic) IBOutlet UIButton *buttonPublish;
@property(nonatomic, retain) UITableView *tableView;

@end


@implementation CommandesViewController
@synthesize arrayOfWineToOrder = _arrayOfWineToOrder;
@synthesize postParams = _postParams;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)publishStory
{
    NSString *texte = [NSString stringWithFormat:
              @"J'ai commandé %d bouteilles",
                             _arrayOfWineToOrder.count];
    self.postParams =
    [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"https://www.lepetitballon.com/", @"link",
     @"http://www.lepetitballon.com/img/logo.png", @"picture",
     @"Lepetitballon", @"name",
     texte, @"caption",
     nil];
    
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:self.postParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         } else {
             alertText = [NSString stringWithFormat:
                          @"Posted action, id: %@",
                          [result objectForKey:@"id"]];
         }
         // Show the result in an alert
         [[[UIAlertView alloc] initWithTitle:@"Result"
                                     message:alertText
                                    delegate:self
                           cancelButtonTitle:@"OK!"
                           otherButtonTitles:nil]
          show];
     }];
}
- (void)viewDidLoad
{    
    if (_arrayOfWineToOrder == nil) {
        _arrayOfWineToOrder = [NSMutableArray  arrayWithObjects:nil];
    } 
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
 
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(12, 50, 280, 45)];
    self.tableView.tableFooterView =footer;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(12, 50, 280, 45)];
    self.tableView.tableHeaderView =header;
 
    [super viewDidLoad];
   
    _buttonPublish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonPublish setFrame:CGRectMake(12, 8, 280, 30)];
    [_buttonPublish setTitle:@"Publier" forState:UIControlStateNormal];
    [_buttonPublish addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
       [_buttonPublish setHidden:TRUE];
    [footer addSubview:_buttonPublish];
    
    _buttonLoginLogout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonLoginLogout setFrame:CGRectMake(18, 8, 280, 30)];
    [_buttonLoginLogout setTitle:@"Facebook" forState:UIControlStateNormal];
    [_buttonLoginLogout addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:_buttonLoginLogout];
    [self updateView];
    
    
    if (!appDelegate.session.isOpen) {
                appDelegate.session = [[FBSession alloc] init];
        
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
- (void)updateView {
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
           [FBSession setActiveSession:appDelegate.session];
        // valid account UI is shown whenever the session is open
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [_buttonPublish setHidden:FALSE];
 
    } else {
        // login-needed account UI is shown whenever the session is closed
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
        [_buttonPublish setHidden:TRUE];
        //  [self.textNoteOrLink setText:@"Login to create a link to fetch account data"];
    }
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
 
 //  NSLog([NSString stringWithFormat:@"count : %d",[_arrayOfWineToOrder count]],@"ee");
    
    return [_arrayOfWineToOrder count];
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
    
   cell.myLabel.text = [[_arrayOfWineToOrder objectAtIndex:[indexPath row]]name];
    
    return cell;
    
}
 

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //  cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    
}

#pragma mark - FBSession logic
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
- (IBAction)shareButtonAction:(id)sender {
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
 
    if (appDelegate.session.isOpen) {
        // Ask for publish_actions permissions in context
        if ([appDelegate.session.permissions
             indexOfObject:@"publish_actions"] == NSNotFound) {
            // No permissions found in session, ask for it
            [appDelegate.session reauthorizeWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
             defaultAudience:FBSessionDefaultAudienceFriends
             completionHandler:^(FBSession *session, NSError *error) {
                 if (!error) {
                     // If permissions granted, publish the story
                     [self publishStory];
                 }
             }];
        } else {
            // If permissions present, publish the story
            [self publishStory];
        }

        
    }else{
        NSLog(@"eeze");
    }
  }

@end
