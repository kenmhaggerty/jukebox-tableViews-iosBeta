//
//  FISAddSongTableViewController.h
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/17/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISSong.h"

@class FISAddSongTableViewController;

@protocol FISAddSongTableViewControllerDelegate <NSObject>
- (void)addSongTableViewControllerDidCancel:(FISAddSongTableViewController *)sender;
- (void)addSongTableViewController:(FISAddSongTableViewController *)sender addSong:(FISSong *)song;
@optional
- (BOOL)addSongTableViewController:(FISAddSongTableViewController *)sender canAddSong:(FISSong *)song;
@end

@interface FISAddSongTableViewController : UITableViewController
@property (nonatomic, weak) id <FISAddSongTableViewControllerDelegate> delegate;
@end
