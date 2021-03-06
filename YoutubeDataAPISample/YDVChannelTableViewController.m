//
//  YDVChannelTableViewController.m
//  YoutubeDataAPISample
//
//  Created by Abhijeet Mishra on 13/02/18.
//  Copyright © 2018 Abhijeet Mishra. All rights reserved.
//

#import "YDVChannelTableViewController.h"
#import "YDVideoTableViewCell.h"

@interface YDVChannelTableViewController ()

@property (nonatomic) NSArray* videoList;

@end

@implementation YDVChannelTableViewController

- (void) viewDidLoad {
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = 180;
}


- (void) viewDidAppear:(BOOL)animated {
    [self getVideoList];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YDVideoTableViewCell class]) forIndexPath:indexPath];
    [cell.playerView loadWithVideoId:self.videoList[indexPath.row]];
    return cell;
}

#pragma mark - API Methods

- (void) getVideoList {
    
    //firebase channel being used
    NSString* urlString = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?channelId=UCP4bf6IHJJQehibu6ai__cg&access_token=%@&part=snippet",[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]];
    
    NSURLSessionConfiguration* sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
 //   NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            self.videoList = @[];
            
            NSMutableArray* newVideoList = [@[] mutableCopy];
            
            NSArray* videoItems = responseDict[@"items"];
            
            for (NSDictionary* videoDict in videoItems) {
                NSString* videoID = videoDict[@"id"][@"videoId"];
                [newVideoList addObject:videoID];
            }
            self.videoList = [newVideoList copy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    [dataTask resume];
}

@end
