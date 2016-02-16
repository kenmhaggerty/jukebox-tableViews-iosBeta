//
//  FISPlaylistTableViewController.m
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/16/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "FISPlaylistTableViewController.h"
#import "FISJukeboxTableViewController.h"

@interface FISPlaylistTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation FISPlaylistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (![segue.identifier isEqualToString:@"segueJukebox"]) return;
    
    FISJukeboxTableViewController *jukebox = (FISJukeboxTableViewController *)segue.destinationViewController;
    // fetch playlist
    
    [jukebox setPlaylist:<#playlist#>];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return <#number of playlists#>;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playlistCell" forIndexPath:indexPath];
    
    [cell.textLabel setText:<#playlist name#>];
    [cell.detailTextLabel setText:<#number of songs#>];
    
    return cell;
}

@end
