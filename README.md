# LGLSearchBar

>  使用方法 
```
LGLSearchBar * searchBar = [[LGLSearchBar alloc] initWithFrame:CGRectMake(10, 200, SCREENWIDTH - 20, 40) searchBarStyle:LGLSearchBarStyleDefault];
    [searchBar searchBarTextSearchTextBlock:^(NSString *searchText) {
        NSLog(@"%@", searchText);
    }];

```
