//
//  FISPlaylistTableViewController.h
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/16/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISPlaylist.h"

@interface FISPlaylistTableViewController : UIViewController
@property (nonatomic, strong) NSArray <FISPlaylist *> *playlists;
@end
