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
    
    FISPlaylist *playlist1 = [[FISPlaylist alloc] init];
    [playlist1 setName:@"Exercise Mix"];
    FISPlaylist *playlist2 = [[FISPlaylist alloc] init];
    [playlist2 setName:@"Chill Mix"];
    [self setPlaylists:@[playlist1, playlist2]];
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
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    FISPlaylist *playlist = self.playlists[indexPath.row];
    
    [jukebox setPlaylist:playlist];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.playlists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playlistCell" forIndexPath:indexPath];
    
    FISPlaylist *playlist = self.playlists[indexPath.row];
    [cell.textLabel setText:playlist.name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%lu %@", playlist.songs.count, (playlist.songs.count == 1 ? @"song" : @"songs")]];
    
    return cell;
}

@end
