//
//  FISJukeboxTableViewController.m
//  Jukebox-TableViews
//
//  Created by Ken M. Haggerty on 2/16/16.
//  Copyright © 2016 Zachary Drossman. All rights reserved.
//

#import "FISJukeboxTableViewController.h"

@interface FISJukeboxTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
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
    
    return <#number of songs#>;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell" forIndexPath:indexPath];
    
    [cell.textLabel setText:<#song title#>];
    [cell.detailTextLabel setText:<#artist#>];
    
    return cell;
}

- (IBAction)play:(UIButton *)sender {
    
    //
}

- (IBAction)sort:(UISegmentedControl *)sender {
    
    //
}

@end
