//
//  BGSettingController.m
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/12.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGSettingController.h"
#import "BGSettingCell.h"
#import "BGSetting.h"
#import "BGGroup.h"

#import "BGInfoController.h"
#import <MessageUI/MessageUI.h>
#import "SVProgressHUD/SVProgressHUD.h"


#import "BGAppsController.h"

@interface BGSettingController ()<UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *settingArray;

@end

@implementation BGSettingController

//lazy load of Table view
- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (NSMutableArray *)settingArray
{
    if (_settingArray == nil) {
        
        _settingArray = [NSMutableArray array];
        
        //first group
        BGSetting *setting1 = [BGSetting settingWithTitle:@"ئەپ ھەققىدە" withIcon:@"setting_info"];
        setting1.desClass = [BGInfoController class];
        BGGroup *group1 = [[BGGroup alloc] init];
        group1.group = @[setting1];
        
        //second group
        BGSetting *setting2 = [BGSetting settingWithTitle:@"ئۇيغۇربەگ ئەپلىرى" withIcon:@"setting_app"];
        setting2.desClass = [BGAppsController class];

        BGSetting *setting3 = [BGSetting settingWithTitle:@"ئۇيغۇربەگ بلوگى" withIcon:@"setting_blog"];
        setting3.block =  ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.uyghurbeg.cn"]];
        };
        BGGroup *group2 = [[BGGroup alloc] init];
        group2.group = @[setting2,setting3];

        //third group
        BGSetting *setting4 = [BGSetting settingWithTitle:@"ئېلخەت يوللاڭ" withIcon:@"setting_mail"];
        
        setting4.block = ^{
            
            NSString *titleText = @"فونىتزار ئەپىدىن سالام";
            NSArray *mailToWhom = [NSArray arrayWithObject:@"uyghurbeg@yahoo.com"];
            NSString *bodyText = @"ئەسسالامۇ ئەلەيكۇم، مەن فونىتزار ناملىق ئەپدىن سىزگە خەت يېزىۋاتىمەن.";
            MFMailComposeViewController *mfc = [[MFMailComposeViewController alloc]init];
            
            mfc.mailComposeDelegate = self;
            [mfc setToRecipients:mailToWhom];
            [mfc setTitle:titleText];
            [mfc setMessageBody:bodyText isHTML:NO];
            
            [self presentViewController:mfc animated:YES completion:NULL];

        };
        
        BGSetting *setting5 = [BGSetting settingWithTitle:@"ئەپكە باھا بېرىڭ" withIcon:@"setting_rate"];
        
    setting5.block = ^{
        NSString *appid = @"1102852103";
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
         };
        BGGroup *group3 = [[BGGroup alloc] init];
        group3.group = @[setting4,setting5];
        
        [_settingArray addObject:group1];
        [_settingArray addObject:group2];
        [_settingArray addObject:group3];
    }
    
    return _settingArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView];
    
    [self setBacktoHomeButton]; //back to home btn
    
    [self setNavigation]; // set the navigation bar
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            [SVProgressHUD showErrorWithStatus:@"ۋاز كېچىلدى"];
            break;
        case MFMailComposeResultSaved:
            [SVProgressHUD showSuccessWithStatus:@"ئارىگىنال ساقلاندى"];
            break;
        case MFMailComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"ئېلخەت يوللاندى"];
            break;
        case MFMailComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"ئېلخەت يوللانمىدى"];
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

//set the navigation bar
- (void)setNavigation
{
  
    self.navigationItem.title = @"ھەققىمىزدە";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"UKIJ Ekran" size:18.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.29 green:0.30 blue:0.29 alpha:1.00]];
    
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleDone target:nil action:nil];
}

//set back to home button
- (void)setBacktoHomeButton
{
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backToHome)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
}

//back to home
- (void)backToHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BGGroup *group = self.settingArray[section];
    return group.group.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingCell";
    
    BGSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BGSettingCell" owner:self options:nil] lastObject];
    }
    
    BGGroup *group = self.settingArray[indexPath.section];
    BGSetting *setting = group.group[indexPath.row];
    
    cell.nameLabel.text = setting.title;
    cell.iconImage.image = [UIImage imageNamed:setting.icon];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BGGroup *group = self.settingArray[indexPath.section];
    BGSetting *setting = group.group[indexPath.row];
   
    if ([setting isKindOfClass:[BGSetting class]]) {
        
        
        if (setting.block) {
            setting.block();
            return;
        }
        
        UIViewController *view = [[setting.desClass alloc] init];
        [self.navigationController pushViewController:view animated:YES];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    }
    
}

@end
