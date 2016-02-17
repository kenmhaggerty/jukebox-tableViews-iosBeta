//
//  FISJukeboxTableViewController.m
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/16/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "FISJukeboxTableViewController.h"
#import <AVFoundation/AVFoundation.h>

#define MILLISECONDS 500
#define ANIMATION_DURATION 0.3f

#define STOP_IMAGE [UIImage imageNamed:@"stop_icon"]
#define PLAY_IMAGE [UIImage imageNamed:@"play_icon"]

@interface FISJukeboxTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) IBOutlet UIView *playView;
@property (nonatomic, weak) IBOutlet UILabel *songLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;
@property (nonatomic, weak) IBOutlet UILabel *albumLabel;
@property (nonatomic, weak) IBOutlet UILabel *progressLabel;
@property (nonatomic, weak) IBOutlet UIView *infoView;
@property (nonatomic, weak) FISSong *currentSong;
- (IBAction)play:(UIButton *)sender;
- (IBAction)sort:(UISegmentedControl *)sender;
@end

@implementation FISJukeboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.playButton setBackgroundImage:PLAY_IMAGE forState:UIControlStateNormal];
    
    [self.infoView setAlpha:0.0f];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, self.playView.frame.size.height, self.tableView.contentInset.right);
    [self.tableView setContentInset:insets];
    [self.tableView setScrollIndicatorInsets:insets];
    
    [self.progressView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressViewWasTapped:)]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self sort:self.segmentedControl];
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
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ • %@", song.artist, song.album]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FISSong *song = self.playlist.songs[indexPath.row];
    [self playSong:song];
}

- (IBAction)play:(UIButton *)sender {
    
    BOOL play = [[sender backgroundImageForState:UIControlStateNormal] isEqual:PLAY_IMAGE];
    FISSong *song = (play ? self.playlist.songs[0] : nil);
    [self playSong:song];
}

- (void)playSong:(FISSong *)song {
    
    [self.playButton setBackgroundImage:(song ? STOP_IMAGE : PLAY_IMAGE) forState:UIControlStateNormal];
    [self.timer invalidate];
    [self.progressView setProgress:0.0f animated:NO];
    
    if (song) [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.playlist.songs indexOfObject:song] inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    else [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    
    [UIView animateWithDuration:ANIMATION_DURATION*0.5f animations:^{
        [self.infoView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self setCurrentSong:song];
        if (song) {
            [self.songLabel setText:song.title];
            [self.artistLabel setText:song.artist];
            [self.albumLabel setText:song.album];
            [self.progressLabel setText:@"0:00"];
            [UIView animateWithDuration:ANIMATION_DURATION*0.5f animations:^{
                [self.infoView setAlpha:1.0f];
            }];
            [self setupAVAudioPlayWithFileName:song.fileName];
            [self.audioPlayer play];
            [self setTimer:[NSTimer scheduledTimerWithTimeInterval:MILLISECONDS/1000.0f target:self selector:@selector(updateProgressView) userInfo:nil repeats:YES]];
            return;
        }
        else {
            [self.audioPlayer stop];
        }
    }];
}

- (IBAction)sort:(UISegmentedControl *)sender {
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    FISSong *selectedSong = (indexPath ? self.playlist.songs[indexPath.row] : nil);
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
    if (selectedSong) [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.playlist.songs indexOfObject:selectedSong] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
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

- (void)updateProgressView {
    
    if (!self.audioPlayer.playing) {
        FISSong *nextSong;
        if (![self.currentSong isEqual:[self.playlist.songs lastObject]]) {
            nextSong = self.playlist.songs[[self.playlist.songs indexOfObject:self.currentSong]+1];
        }
        [self playSong:nextSong];
        return;
    }
    
    [self.progressView setProgress:self.audioPlayer.currentTime/self.audioPlayer.duration animated:YES];
    [self.progressLabel setText:[NSString stringWithFormat:@"%d:%02d", (int)floorf(self.audioPlayer.currentTime/60.0f), (int)self.audioPlayer.currentTime % 60]];
}

- (void)progressViewWasTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    if (!self.audioPlayer.playing) return;
    
    [self.progressView setProgress:[tapGestureRecognizer locationInView:self.progressView].x/self.progressView.bounds.size.width animated:NO];
    [self.audioPlayer setCurrentTime:self.audioPlayer.duration*self.progressView.progress];
}

@end
