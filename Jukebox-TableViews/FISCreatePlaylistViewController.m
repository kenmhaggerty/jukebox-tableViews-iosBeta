//
//  FISCreatePlaylistViewController.m
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/17/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "FISCreatePlaylistViewController.h"

@interface FISCreatePlaylistViewController ()
@property (nonatomic, weak) IBOutlet UIBarButtonItem *createButton;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation FISCreatePlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.createButton setEnabled:NO];
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

- (IBAction)cancel:(id)sender {
    
    [self.textField resignFirstResponder];
    [self.delegate createPlaylistViewControllerDidCancel:self];
}

- (IBAction)create:(id)sender {
    
    [self.textField resignFirstResponder];
    [self.delegate createPlaylistViewController:self createPlaylistWithName:self.textField.text];
}

- (IBAction)textFieldDidChange:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(createPlaylistViewController:canCreatePlaylistWithName:)]) {
        [self.createButton setEnabled:[self.delegate createPlaylistViewController:self canCreatePlaylistWithName:self.textField.text]];
    }
}

@end
