//
//  LanguageTableViewController.m
//  
//
//  Created by Cathy Oun on 2/3/16.
//
//

#import "LanguageTableViewController.h"

@interface LanguageTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *languageList;

@end

@implementation LanguageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.languageList = @[@"English", @"Español", @"中文", @"Français", @"한국어"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.languageList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LanguageCell" forIndexPath:indexPath];
  cell.textLabel.text = self.languageList[indexPath.row];
  cell.accessoryType = [cell.textLabel.text isEqualToString:@"English"] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // delegate
  [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSIndexPath *oldIndex = [self.tableView indexPathForSelectedRow];
  [self.tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
  [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
  return indexPath;
}

@end
