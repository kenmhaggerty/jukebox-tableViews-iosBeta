//
//  FISCreatePlaylistViewController.h
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/17/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISCreatePlaylistViewController;

@protocol FISCreatePlaylistViewControllerDelegate <NSObject>
- (void)createPlaylistViewControllerDidCancel:(FISCreatePlaylistViewController *)sender;
- (void)createPlaylistViewController:(FISCreatePlaylistViewController *)sender createPlaylistWithName:(NSString *)name;
@optional
- (BOOL)createPlaylistViewController:(FISCreatePlaylistViewController *)sender canCreatePlaylistWithName:(NSString *)name;
@end

@interface FISCreatePlaylistViewController : UIViewController
@property (nonatomic, strong) id <FISCreatePlaylistViewControllerDelegate> delegate;
@end
