//
//  UISearchBar+ZH.m
//  ZHCommonKit
//
//  Created by Mac on 2018/12/17.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "UISearchBar+ZHAdd.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^ZH_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^ZH_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^ZH_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^ZH_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^ZH_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (ZHAdd)

static const void *ZH_UISearchBarDelegateKey                                = &ZH_UISearchBarDelegateKey;
static const void *ZH_UISearchBarShouldBeginEditingKey                      = &ZH_UISearchBarShouldBeginEditingKey;
static const void *ZH_UISearchBarTextDidBeginEditingKey                     = &ZH_UISearchBarTextDidBeginEditingKey;
static const void *ZH_UISearchBarShouldEndEditingKey                        = &ZH_UISearchBarShouldEndEditingKey;
static const void *ZH_UISearchBarTextDidEndEditingKey                       = &ZH_UISearchBarTextDidEndEditingKey;
static const void *ZH_UISearchBarTextDidChangeKey                           = &ZH_UISearchBarTextDidChangeKey;
static const void *ZH_UISearchBarShouldChangeTextInRangeKey                 = &ZH_UISearchBarShouldChangeTextInRangeKey;
static const void *ZH_UISearchBarSearchButtonClickedKey                                = &ZH_UISearchBarSearchButtonClickedKey;
static const void *ZH_UISearchBarBookmarkButtonClickedKey                                = &ZH_UISearchBarBookmarkButtonClickedKey;
static const void *ZH_UISearchBarCancelButtonClickedKey                                = &ZH_UISearchBarCancelButtonClickedKey;
static const void *ZH_UISearchBarResultsListButtonClickedKey                                = &ZH_UISearchBarResultsListButtonClickedKey;
static const void *ZH_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &ZH_UISearchBarSelectedScopeButtonIndexDidChangeKey;


#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    ZH_UISearchBarReturnBlock block = searchBar.zh_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    ZH_UISearchBarVoidBlock block = searchBar.zh_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    ZH_UISearchBarReturnBlock block = searchBar.zh_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    ZH_UISearchBarVoidBlock block = searchBar.zh_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    ZH_UISearchBarSearchTextBlock block = searchBar.zh_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    ZH_UISearchBarInRangeReplacementTextBlock block = searchBar.zh_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    ZH_UISearchBarVoidBlock block = searchBar.zh_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    ZH_UISearchBarVoidBlock block = searchBar.zh_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    ZH_UISearchBarVoidBlock block = searchBar.zh_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    ZH_UISearchBarVoidBlock block = searchBar.zh_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    ZH_UISearchBarScopeIndexBlock block = searchBar.zh_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, ZH_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))zh_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarShouldBeginEditingKey);
}

- (void)setZh_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))zh_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,ZH_UISearchBarTextDidBeginEditingKey);
}

- (void)setZh_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))zh_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarShouldEndEditingKey);
}

- (void)setZh_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))zh_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarTextDidEndEditingKey);
}

- (void)setZh_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))zh_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarTextDidChangeKey);
}

- (void)setZh_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))zh_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setZh_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))zh_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarSearchButtonClickedKey);
}

- (void)setZh_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))zh_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarBookmarkButtonClickedKey);
}

- (void)setZh_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))zh_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarCancelButtonClickedKey);
}

- (void)setZh_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))zh_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarResultsListButtonClickedKey);
}

- (void)setZh_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))zh_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, ZH_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setZh_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self zh_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZH_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)zh_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, ZH_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}



@end
