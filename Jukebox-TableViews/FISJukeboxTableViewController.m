//
//  FISJukeboxTableViewController.m
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/16/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "FISJukeboxTableViewController.h"
#import <AVFoundation/AVFoundation.h>

#define STOP_TEXT @"◼︎"
#define PLAY_TEXT @"►"

@interface FISJukeboxTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
- (IBAction)play:(UIButton *)sender;
- (IBAction)sort:(UISegmentedControl *)sender;
@end

@implementation FISJukeboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.playlist.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell" forIndexPath:indexPath];
    
    FISSong *song = self.playlist.songs[indexPath.row];
    [cell.textLabel setText:song.title];
    [cell.detailTextLabel setText:song.artist];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FISSong *song = self.playlist.songs[indexPath.row];
    [self playSong:song];
}

- (IBAction)play:(UIButton *)sender {
    
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:STOP_TEXT]) {
        [self.audioPlayer stop];
        [sender setTitle:PLAY_TEXT forState:UIControlStateNormal];
        return;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (!indexPath) indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    FISSong *song = self.playlist.songs[indexPath.row];
    [self playSong:song];
}

- (void)playSong:(FISSong *)song {
    
    [self setupAVAudioPlayWithFileName:song.fileName];
    [self.audioPlayer play];
}

- (IBAction)sort:(UISegmentedControl *)sender {
    
    if ([[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] isEqualToString:@"Title"]) {
        [self.playlist sortSongsByTitle];
    }
    else if ([[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] isEqualToString:@"Album"]) {
        [self.playlist sortSongsByAlbum];
    }
    else if ([[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] isEqualToString:@"Artist"]) {
        [self.playlist sortSongsByArtist];
    }
    [self.tableView reloadData];
}

- (void)setupAVAudioPlayWithFileName:(NSString *)fileName
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:fileName
                                         ofType:@"mp3"]];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!self.audioPlayer) {
        NSLog(@"Error in audioPlayer: %@", error.localizedDescription);
    } else {
        [self.audioPlayer prepareToPlay];
    }
}

@end
