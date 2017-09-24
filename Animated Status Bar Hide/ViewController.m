//
//  ViewController.m
//  Animated Status Bar Hide
//
//  Created by Mohammad Abu-Garbeyyeh on 24/9/17.
//  Copyright © 2017 Mohammad Abu-Garbeyyeh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIViewPropertyAnimator *animator;
    BOOL _statusBarHidden;
    BOOL _useAnimation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusBarHidden = NO;
    // Do any additional setup after loading the view, typically from a nib.
    
    animator = [[UIViewPropertyAnimator alloc] initWithDuration:1.0 curve:UIViewAnimationCurveEaseIn animations:^{
        _statusBarHidden = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_useAnimation) {
        return;
    }
    
    CGFloat progress = scrollView.contentOffset.y + scrollView.adjustedContentInset.top;
    animator.fractionComplete = fminf(progress / 64, 1);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _useAnimation = YES; // Workaround for scrollViewDidScroll being called without actually scrolling when the view comes up
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}

@end
