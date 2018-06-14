//
//  BGInfoController.m
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/12.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGInfoController.h"

@interface BGInfoController ()

@end

@implementation BGInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appIcon.layer.cornerRadius = 10;
    self.appIcon.layer.masksToBounds = YES;
    self.title = @"ئەپ ھەققىدە";

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

@end
