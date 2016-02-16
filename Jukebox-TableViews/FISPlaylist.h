//  FISPlaylist.h

#import <Foundation/Foundation.h>
#import "FISSong.h"

@interface FISPlaylist : NSObject

@property (nonatomic, strong) NSString *name;
@property (strong, nonatomic) NSMutableArray *songs;
@property (strong, nonatomic) NSString *text;

- (NSString *)textForSongs;

- (void)sortSongsByTitle;

- (void)sortSongsByArtist;

- (void)sortSongsByAlbum;

- (FISSong *)songForTrackNumber:(NSUInteger)trackNumber;

@end
