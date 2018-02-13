//
//  YDListViewController.m
//  YoutubeDataAPISample
//
//  Created by Abhijeet Mishra on 12/02/18.
//  Copyright © 2018 Abhijeet Mishra. All rights reserved.
//

#import "YDListViewController.h"

@interface YDListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation YDListViewController

#pragma mark - Helper Methods

- (NSArray*) yd_getOptions {
    return @[@"Upload a video"];
}

#pragma mark - UITableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self yd_getOptions].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    cell.textLabel.text = [self yd_getOptions][indexPath.row];
    return cell;
}


@end
