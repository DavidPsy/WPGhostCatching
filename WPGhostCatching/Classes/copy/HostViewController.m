
#import "HostViewController.h"
#import "WPServerVC.h"
#import "WPDataCenter.h"

@interface HostViewController ()
@property (nonatomic, weak) IBOutlet UITableView *listView;
@property (nonatomic, weak) IBOutlet UITextField *txtGhost;;
@property (nonatomic, weak) IBOutlet UITextField *txtPlayer;
@end

@implementation HostViewController
{
	MatchmakingServer *_matchmakingServer;
	QuitReason _quitReason;
    
    NSArray *_tmpWordsArray;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    _tmpWordsArray = @[@"我是猪",@"我不是猪",
                       @"伴郎",@"伴娘",
                       @"人妖",@"太监",
                       @"键盘",@"跪键盘",
                       @"发春",@"叫春",
                       @"银行卡",@"信用卡",
                       @"我很变态",@"我不变态",
                       @"胸罩",@"凶兆",
                       @"电视",@"电击",
                       @"口袋",@"口水"];
    
    UITapGestureRecognizer *gestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
	gestureRecognizer2.cancelsTouchesInView = NO;
	[self.view addGestureRecognizer:gestureRecognizer2];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
	if (_matchmakingServer == nil)
	{
		_matchmakingServer = [[MatchmakingServer alloc] init];
		_matchmakingServer.delegate = self;
		_matchmakingServer.maxClients = 3;
		[_matchmakingServer startAcceptingConnectionsForSessionID:SESSION_ID];
        
//		self.nameTextField.placeholder = _matchmakingServer.session.displayName;
		[self.listView reloadData];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)startAction:(id)sender
{
    if (_matchmakingServer != nil && [_matchmakingServer connectedClientCount] > 0)
	{
		NSString *ghostname = [self.txtGhost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *playerName = [self.txtPlayer.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
		if ([ghostname length] == 0 || [playerName length] == 0) {
            MTAlert(@"必须输入词组");
            return;
        }
        
        if ([_matchmakingServer.connectedClients count] <= 2) {
            MTAlert(@"至少得3人，等人来了再开始吧");
            return;
        }
        
		[_matchmakingServer stopAcceptingConnections];
        
        [WPDataCenter shareInstance].ghostWords = ghostname;
        [WPDataCenter shareInstance].playerWords = playerName;
        [[WPDataCenter shareInstance] startServerGameWithSession:_matchmakingServer.session playerName:nil clients:_matchmakingServer.connectedClients];
        
        [self performSegueWithIdentifier:@"toServerVC" sender:self];

	}
}

- (IBAction)autoGenerateWords:(id)sender {
    int index = arc4random() % (_tmpWordsArray.count/2);
    self.txtGhost.text = _tmpWordsArray[index * 2];
    self.txtPlayer.text = _tmpWordsArray[index * 2 + 1];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSMutableArray *playersArray = [NSMutableArray array];
    for (NSString *peerID in _matchmakingServer.connectedClients) {
        [playersArray addObject:[_matchmakingServer.session displayNameForPeer:peerID]];
    }
    ((WPServerVC *)(segue.destinationViewController)).playerPeerIDs = _matchmakingServer.connectedClients;
    ((WPServerVC *)(segue.destinationViewController)).players = playersArray;
}

- (IBAction)exitAction:(id)sender
{
	_quitReason = QuitReasonUserQuit;
	[_matchmakingServer endSession];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_matchmakingServer != nil)
		return [_matchmakingServer connectedClientCount];
	else
		return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CellIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	NSString *peerID = [_matchmakingServer peerIDForConnectedClientAtIndex:indexPath.row];
	cell.textLabel.text = [_matchmakingServer displayNameForPeerID:peerID];
    
	return cell;
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

#pragma mark - UITextFieldDelegate

- (void)onTap {
    [self.txtGhost resignFirstResponder];
    [self.txtPlayer resignFirstResponder];
}

#pragma mark - MatchmakingServerDelegate

- (void)matchmakingServer:(MatchmakingServer *)server clientDidConnect:(NSString *)peerID
{
	[self.listView reloadData];
}

- (void)matchmakingServer:(MatchmakingServer *)server clientDidDisconnect:(NSString *)peerID
{
	[self.listView reloadData];
}

- (void)matchmakingServerSessionDidEnd:(MatchmakingServer *)server
{
	_matchmakingServer.delegate = nil;
	_matchmakingServer = nil;
	[self.listView reloadData];
}

- (void)matchmakingServerNoNetwork:(MatchmakingServer *)session
{
	_quitReason = QuitReasonNoNetwork;
}

@end
