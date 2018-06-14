//
//  ViewController.m
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/11.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "ViewController.h"
#import "BGFonts.h"

#import "BGSettingController.h"
#import "SCLAlertView.h"

//define the UIScreenSize
#define kUIScreenBounds  [[UIScreen mainScreen] bounds]
#define kMargin 10

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *fontList;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *fontLabel;

@end

@implementation ViewController

//lazy load of head view

- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        CGFloat headX = 0;
        CGFloat headY = 0;
        CGFloat headW = kUIScreenBounds.size.width;
        CGFloat headH = (kUIScreenBounds.size.height / 3) + 30;
        
        _headView.frame = CGRectMake(headX, headY, headW, headH);
        _headView.backgroundColor = [UIColor colorWithRed:0.29 green:0.30 blue:0.29 alpha:1.00];
        [self.view addSubview:_headView];
        
        //buttons W,H,Y
        CGFloat buttonW = 18; //
        CGFloat buttonH = 18; //buttons Heigh
        CGFloat buttonY = self.headView.frame.size.height - kMargin - buttonH; //buttons Y
        
        //create textLeftButton
        CGFloat buttonLX = 2 * kMargin;
        CGRect  buttonLFrame = CGRectMake(buttonLX, buttonY, buttonW, buttonH);
        UIButton *leftButton = [[UIButton alloc] initWithFrame:buttonLFrame];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"button_left"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(textAlignLeft) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:leftButton];
        
        
        //create textCenterButton
        CGFloat buttonCX = self.headView.frame.size.width * 0.5 - buttonW * 0.5;
        CGRect  buttonCFrame = CGRectMake(buttonCX, buttonY, buttonW, buttonH);
        UIButton *centerButton = [[UIButton alloc] initWithFrame:buttonCFrame];
        [centerButton setBackgroundImage:[UIImage imageNamed:@"button_center"] forState:UIControlStateNormal];
        [centerButton addTarget:self action:@selector(textAlignCenter) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:centerButton];

        //create textRightButton
        CGFloat buttonRX = self.headView.frame.size.width - 2*kMargin - buttonW;
        CGRect  buttonRFrame = CGRectMake(buttonRX, buttonY, buttonW, buttonH);
        UIButton *rightButton = [[UIButton alloc] initWithFrame:buttonRFrame];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"button_right"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(textAlignRight) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:rightButton];
        
        //add Setting_Button
        CGFloat settingX = kMargin;
        CGFloat settingY = 3 * kMargin;
        CGFloat settingW = 22;
        CGFloat settingH = settingW;
        UIButton *settingBtn = [[UIButton alloc] init];
        settingBtn.frame = CGRectMake(settingX, settingY, settingW, settingH);
        
        [settingBtn setBackgroundImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
        [settingBtn addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:settingBtn];
        
        //add Texxt_Button
        CGFloat textX = kUIScreenBounds.size.width - settingW - kMargin;
        CGFloat textY = 3 * kMargin;
        CGFloat textW = 22;
        CGFloat textH = settingW;
        UIButton *textBtn = [[UIButton alloc] init];
        textBtn.frame = CGRectMake(textX, textY, textW, textH);
        
        [textBtn setBackgroundImage:[UIImage imageNamed:@"addText"] forState:UIControlStateNormal];
        [textBtn addTarget:self action:@selector(addText) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:textBtn];
        

    }
    
    return _headView;
}

//lazy load of Table view
- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        CGFloat tableX = 0;
        CGFloat tableY = CGRectGetMaxY(self.headView.frame);;
        CGFloat tableW = kUIScreenBounds.size.width;
        CGFloat tableH = kUIScreenBounds.size.height - self.headView.frame.size.height;
        
        CGRect tableFrame = CGRectMake(tableX, tableY, tableW, tableH);

        _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //set row-height
        _tableView.rowHeight = 60;
        
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

//Lazy load for fontList
- (NSMutableArray *)fontList
{
    if (_fontList == nil) {
        
        _fontList = [NSMutableArray array];
        
        
        //add model
        NSArray *tArray = [BGFonts fonts];
        [_fontList addObjectsFromArray:tArray];
    }
    return _fontList;
}

//Lazy load for fontLabel

- (UILabel *)fontLabel
{
    if (_fontLabel == nil) {
        _fontLabel = [[UILabel alloc] init];
        CGFloat labelX = 10;
        CGFloat labelY = self.headView.frame.size.height * 0.5 - 15;
        CGFloat labelW = kUIScreenBounds.size.width - 20;
        CGFloat labelH = 30;
        
        _fontLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        _fontLabel.textColor = [UIColor whiteColor];
        _fontLabel.text = @"مەن پروگراممىنى سۆيىمەن";
        _fontLabel.textAlignment = NSTextAlignmentCenter;
        _fontLabel.font = [UIFont systemFontOfSize:24.0f];
        [self.view addSubview:_fontLabel];
    }
    return _fontLabel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self headView]; //show the head view
 
    [self tableView]; //show the tableview

    [self fontLabel];  //show the titleLabel
}


//set the label text to left
- (void)textAlignLeft
{
    self.fontLabel.textAlignment = NSTextAlignmentLeft;
}

//set the label text to center
- (void)textAlignCenter
{
    self.fontLabel.textAlignment = NSTextAlignmentCenter;
}

//set the label text to center
- (void)textAlignRight
{
    self.fontLabel.textAlignment = NSTextAlignmentRight;
}

//go to setting

- (void)gotoSetting
{
    BGSettingController *setting = [[BGSettingController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:setting];
    [self presentViewController:nav animated:YES completion:nil];
}

//add text
- (void)addText
{
    NSString *kInfoTitle = @"دىققەت";
    NSString *kSubtitle = @"ئۈنۈمىنى كۆرمەكچى بولغان قىسقاراق جۈملىنى كىرگۈزۈڭ";
    NSString *kButtonTitle = @"ۋاز كەچتىم";
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UITextView *textField = [alert addTextField:@""];
    textField.textAlignment = NSTextAlignmentRight;
    [alert addButton:@"ئۈنۈمىنى كۆرەي" actionBlock:^(void) {
        self.fontLabel.text = textField.text;
    }];
    
    [alert showEdit:self title:kInfoTitle subTitle:kSubtitle closeButtonTitle:kButtonTitle duration:0.0f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fontList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"iOS System Font";
        cell.textLabel.font = [UIFont systemFontOfSize:19.0];
    }
    
    else
    {
        BGFonts *fonts = self.fontList[indexPath.row - 1];

        
        cell.textLabel.text = fonts.fontName;
        cell.textLabel.font = [UIFont fontWithName:fonts.fontName size:19.0f];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        self.fontLabel.font = [UIFont systemFontOfSize:24.0f];
    }

    else
    {
        BGFonts *fonts = self.fontList[indexPath.row - 1];
        self.fontLabel.font = [UIFont fontWithName:fonts.fontName size:24.0f];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
