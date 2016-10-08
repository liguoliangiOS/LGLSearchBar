//
//  LGLSearchBar.m
//  LGLSearchBar-Dome
//
//  Created by 李国良 on 2016/9/30.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import "LGLSearchBar.h"

@interface LGLSearchBar ()<UISearchBarDelegate>

{
    UISearchBar * _searchBar;
}


@end

@implementation LGLSearchBar

/*
     还需要添加 修改放大镜的图片
 
 
 */

- (instancetype)initWithFrame:(CGRect)frame  searchBarStyle:(LGLSearchBarStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _searchBar.barStyle =  (style == LGLSearchBarStyleDefault) ? UISearchBarStyleDefault : ((style == LGLSearchBarStyleProminent) ? UISearchBarStyleProminent : UISearchBarStyleMinimal);
        _searchBar.placeholder = @"请输入搜索内容";
        
        /*
         UITextAutocapitalizationTypeNone,             除非自己点击大写,否则永不大写
         UITextAutocapitalizationTypeWords,            以单词来区分,每个单词首字母大写
         UITextAutocapitalizationTypeSentences,        以句子来区分
         UITextAutocapitalizationTypeAllCharacters,    所有字母全部大写
         */
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //这个是透视属性
        //_searchBar.translucent = YES;
        _searchBar.delegate = self;
        [self addSubview:_searchBar];
    }
    return self;
}

#pragma mark ====  UITextFeildDElegate =======
// return NO to not resign first responder
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.block(searchBar.text);
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

 // called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.block(searchBar.text);
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

// 重新设置 searchbar cancel按钮 为搜索
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"搜索" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}


#pragma mark ==== 重写set方法 ===============

- (void)setPlaceholderFontSize:(CGFloat )placeholderFontSize {
    _placeholderFontSize = placeholderFontSize;
     [[self searchBarTextFeild] setValue:[UIFont systemFontOfSize:placeholderFontSize] forKeyPath:@"_placeholderLabel.font"];
}

- (void)setTextFontSize:(CGFloat)textFontSize {
    _textFontSize = textFontSize;
    [self searchBarTextFeild].font = [UIFont systemFontOfSize:textFontSize];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _searchBar.placeholder = placeholder;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    _searchBar.tintColor = tintColor;
}

- (void)setBarBackgroudColor:(UIColor *)barBackgroudColor {
    _barBackgroudColor = barBackgroudColor;
     _searchBar.barTintColor = barBackgroudColor;
}

- (void)setTextBackgroudColor:(UIColor *)textBackgroudColor {
    _textBackgroudColor = textBackgroudColor;
    [[[_searchBar.subviews firstObject]subviews]lastObject].backgroundColor = textBackgroudColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [[self searchBarTextFeild] setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self searchBarTextFeild].textColor = textColor;
}

- (void)setSearchBarImage:(NSString *)imageName scale:(CGFloat)scale {
    UIImageView * leftView = [[UIImageView alloc] initWithImage:[self changeImageSize:imageName scale:scale]];
    [self searchBarTextFeild].leftView = leftView;
}

- (void)setTextBordStyle:(LGLTextBorderStyle)textBordStyle {
    _textBordStyle = textBordStyle;
    UITextBorderStyle bordStyle = (textBordStyle == LGLTextBorderStyleNone) ? UITextBorderStyleNone : ((textBordStyle == LGLTextBorderStyleLine) ? UITextBorderStyleLine : ((textBordStyle == LGLTextBorderStyleBezel) ? UITextBorderStyleBezel : UITextBorderStyleRoundedRect));
    [self searchBarTextFeild].borderStyle = bordStyle;
}

- (void)setSearchBarBordeWidth:(CGFloat)Width bordColor:(UIColor *)bordColor bordRadius:(CGFloat)bordcornerRadius {
    UITextField * texFeiled = [self searchBarTextFeild];
    texFeiled.layer.borderWidth = Width;
    texFeiled.layer.borderColor = bordColor.CGColor;
    texFeiled.layer.masksToBounds = YES;
    texFeiled.layer.cornerRadius = bordcornerRadius;

}

- (void)searchBarTextSearchTextBlock:(SearchTextBlock)block {
    self.block = block;
}

// 修改图片的大小
-  (UIImage *)changeImageSize:(NSString *)imageName scale:(CGFloat)scale
{
    NSData *imgData = UIImagePNGRepresentation([UIImage imageNamed:imageName]);
    UIImage * image = [UIImage imageWithData:imgData scale:scale];
    //声明使用自定义的图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
//获取输入框
- (UITextField *)searchBarTextFeild {
    UITextField * texFeild = nil;
    for (UIView* subview in [[_searchBar.subviews lastObject] subviews]) {
        
        if ([subview isKindOfClass:[UITextField class]]) {
            texFeild = (UITextField*)subview;
            
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
        }
    }
    return texFeild;
}
@end
