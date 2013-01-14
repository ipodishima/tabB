#import "CommandesViewController.h"



@interface CommandesViewController ()
@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
@end

@implementation CommandesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
@synthesize buttonLoginLogout = _buttonLoginLogout;
- (void)viewDidLoad
{
    self.title=@"List";
    _dataToShow = [[NSArray alloc] initWithObjects:@"Mon Profil", @"Videos", @"A propos", nil];
    _dataToDraw = [[NSArray alloc] initWithObjects: @"17-bar-chart.png",@"17-bar-chart.png",@"17-bar-chart.png", nil];
    //  UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    // self.tableView.tableFooterView =footer;
    [super viewDidLoad];
    
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

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
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
@end
