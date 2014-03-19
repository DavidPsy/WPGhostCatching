//
//#import "JoinViewController.h"
//#import "WPDataCenter.h"
//#import "WPPlayerVC.h"
//#import "DSActivityView.h"
//
//@interface JoinViewController ()
//
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (nonatomic, weak) IBOutlet UITextField *txtName;
//
//@end
//
//@implementation JoinViewController
//{
//	MatchmakingClient *_matchmakingClient;
//	QuitReason _quitReason;
//}
//
//- (void)viewDidLoad
//{
//	[super viewDidLoad];
//    
//    UITapGestureRecognizer *gestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
//	gestureRecognizer2.cancelsTouchesInView = NO;
//	[self.view addGestureRecognizer:gestureRecognizer2];
//}
//
//- (void)onTap {
//    [self.txtName resignFirstResponder];
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//	[super viewDidAppear:animated];
//
//	if (_matchmakingClient == nil)
//	{
//		_quitReason = QuitReasonConnectionDropped;
//
//		_matchmakingClient = [[MatchmakingClient alloc] init];
//		_matchmakingClient.delegate = self;
//		[_matchmakingClient startSearchingForServersWithSessionID:SESSION_ID];
//
//		self.txtName.placeholder = _matchmakingClient.session.displayName;
//		[self.tableView reloadData];
//	}
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//}
//
//- (IBAction)exitAction:(id)sender
//{
//	_quitReason = QuitReasonUserQuit;
//	[_matchmakingClient disconnectFromServer];
//}
//
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	if (_matchmakingClient != nil)
//		return [_matchmakingClient availableServerCount];
//	else
//		return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *CellIdentifier = @"CellIdentifier";
//
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//	if (cell == nil)
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//
//	NSString *peerID = [_matchmakingClient peerIDForAvailableServerAtIndex:indexPath.row];
//	cell.textLabel.text = [_matchmakingClient displayNameForPeerID:peerID];
//
//	return cell;
//}
//
//#pragma mark - UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//	if (_matchmakingClient != nil)
//	{
//        [DSActivityView activityViewForView:self.view withLabel:@"进入房间中..."];
//        // wait view
//		NSString *peerID = [_matchmakingClient peerIDForAvailableServerAtIndex:indexPath.row];
//		[_matchmakingClient connectToServerWithPeerID:peerID];
//	}
//}
//
//#pragma mark - MatchmakingClientDelegate
//
//- (void)matchmakingClient:(MatchmakingClient *)client serverBecameAvailable:(NSString *)peerID
//{
//	[self.tableView reloadData];
//}
//
//- (void)matchmakingClient:(MatchmakingClient *)client serverBecameUnavailable:(NSString *)peerID
//{
//	[self.tableView reloadData];
//}
//
//- (void)matchmakingClient:(MatchmakingClient *)client didConnectToServer:(NSString *)peerID
//{
//    
//    [DSActivityView removeView];
//    
//	NSString *name = [self.txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//	if ([name length] == 0)
//		name = _matchmakingClient.session.displayName;
//
////	[self.delegate joinViewController:self startGameWithSession:_matchmakingClient.session playerName:name server:peerID];
//    
//    [[WPDataCenter shareInstance] startClientGameWithSession:_matchmakingClient.session playerName:name server:peerID];
//    
//    
//    [self performSegueWithIdentifier:@"toPlayerVC" sender:self];
//}
//
//- (void)matchmakingClient:(MatchmakingClient *)client didDisconnectFromServer:(NSString *)peerID
//{
//	_matchmakingClient.delegate = nil;
//	_matchmakingClient = nil;
//	[self.tableView reloadData];
//}
//
//- (void)matchmakingClientNoNetwork:(MatchmakingClient *)client
//{
//	_quitReason = QuitReasonNoNetwork;
//}
//
//@end
