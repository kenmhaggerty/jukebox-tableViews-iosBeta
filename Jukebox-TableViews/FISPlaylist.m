//  FISPlaylist.m

#import "FISPlaylist.h"

@implementation FISPlaylist

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _name = @"untitled playlist";
        _songs = [self generateSongObjects];
        _text = [self textForSongs];
    }
    
    return self;
}

- (NSMutableArray *)generateSongObjects
{
    NSMutableArray *songs = [[NSMutableArray alloc] init];
        
    [songs addObject:[[FISSong alloc] initWithTitle:@"Hold on Be Strong"
                                             artist:@"Matoma vs Big Poppa"
                                              album:@"The Internet 1"
                                           fileName:@"hold_on_be_strong"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Higher Love"
                                             artist:@"Matoma ft. James Vincent McMorrow"
                                              album:@"The Internet 2"
                                           fileName:@"higher_love"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Mo Money Mo Problems"
                                             artist:@"Matoma ft. The Notorious B.I.G."
                                              album:@"The Internet 3"
                                           fileName:@"mo_money_mo_problems"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Old Thing Back"
                                             artist:@"The Notorious B.I.G."
                                              album:@"The Internet 4"
                                           fileName:@"old_thing_back"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Gangsta Bleeding Love"
                                             artist:@"Matoma"
                                              album:@"The Internet 5"
                                           fileName:@"gangsta_bleeding_love"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Bailando"
                                             artist:@"Enrique Iglesias ft. Sean Paul"
                                              album:@"The Internet 6"
                                           fileName:@"bailando"] ];
    
    return songs;
}

- (NSString *)textForSongs
{
    
    NSMutableString *text = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < self.songs.count; i++) {
        FISSong *song = self.songs[i];
        [text appendFormat:@"%lu. (Title) %@ (Artist) %@ (Album) %@\n", i+1, song.title, song.artist, song.album];
    }
    return text;
}

- (void)sortSongsByTitle
{
    NSSortDescriptor *sortByTitleAsc = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSSortDescriptor *sortByArtistAsc = [[NSSortDescriptor alloc] initWithKey:@"artist" ascending:YES];
    
    NSArray *descriptors = @[sortByTitleAsc, sortByArtistAsc];
    [self.songs sortUsingDescriptors:descriptors];
    
    self.text = [self textForSongs];
}

- (void)sortSongsByArtist
{
    NSSortDescriptor *sortByArtistAsc = [[NSSortDescriptor alloc] initWithKey:@"artist" ascending:YES];
    NSSortDescriptor *sortByAlbumAsc = [[NSSortDescriptor alloc] initWithKey:@"album" ascending:YES];
    NSSortDescriptor *sortByTitleAsc = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    
    NSArray *descriptors = @[sortByArtistAsc, sortByAlbumAsc, sortByTitleAsc];
    [self.songs sortUsingDescriptors:descriptors];
    
    self.text = [self textForSongs];
}

- (void)sortSongsByAlbum
{
    NSSortDescriptor *sortByAlbumAsc = [[NSSortDescriptor alloc] initWithKey:@"album" ascending:YES];
    NSSortDescriptor *sortByTitleAsc = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    
    NSArray *descriptors = @[sortByAlbumAsc, sortByTitleAsc];
    [self.songs sortUsingDescriptors:descriptors];
    
    self.text = [self textForSongs];
}

- (FISSong *)songForTrackNumber:(NSUInteger)trackNumber
{
    BOOL validTrackNumber = trackNumber != 0 && trackNumber <= self.songs.count;
    
    if (validTrackNumber) {
        NSUInteger index = trackNumber - 1;
        FISSong *requestedSong = self.songs[index];
        return requestedSong;
    }
    
    return nil;
}

@end
