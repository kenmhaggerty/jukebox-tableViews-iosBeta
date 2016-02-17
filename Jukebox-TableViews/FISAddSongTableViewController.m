//
//  FISAddSongTableViewController.m
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/17/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "FISAddSongTableViewController.h"
#import "FISPlaylist.h"

@interface FISAddSongTableViewController ()
@property (nonatomic, strong) NSArray *songs;
@end

@implementation FISAddSongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    FISPlaylist *playlist = [[FISPlaylist alloc] init];
    [playlist sortSongsByTitle];
    [self setSongs:playlist.songs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell" forIndexPath:indexPath];
    
    FISSong *song = self.songs[indexPath.row];
    [cell.textLabel setText:song.title];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ • %@", song.artist, song.album]];
    BOOL canAdd = YES;
    if ([self.delegate respondsToSelector:@selector(addSongTableViewController:canAddSong:)]) {
        canAdd = [self.delegate addSongTableViewController:self canAddSong:song];
    }
    [cell.textLabel setTextColor:(canAdd ? [UIColor blackColor] : [UIColor lightGrayColor])];
    [cell.detailTextLabel setTextColor:(canAdd ? [UIColor blackColor] : [UIColor lightGrayColor])];
    [cell setUserInteractionEnabled:canAdd];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate addSongTableViewController:self addSong:self.songs[indexPath.row]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    
    [self.delegate addSongTableViewControllerDidCancel:self];
}

@end
