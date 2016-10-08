//
//  ViewController.m
//  LGLSearchBar-Dome
//
//  Created by 李国良 on 2016/9/30.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import "ViewController.h"
#import "LGLSearchBar.h"

#define SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LGLSearchBar * searchBar = [[LGLSearchBar alloc] initWithFrame:CGRectMake(10, 200, SCREENWIDTH - 20, 40) searchBarStyle:LGLSearchBarStyleDefault];
    [searchBar searchBarTextSearchTextBlock:^(NSString *searchText) {
        NSLog(@"%@", searchText);
    }];
    [self.view addSubview:searchBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
