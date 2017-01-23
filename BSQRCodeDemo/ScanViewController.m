//
//  ScanViewController.m
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/23.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "ScanViewController.h"
#import "BSQRCamera.h"
#import "MaskView.h"

#import <AVFoundation/AVFoundation.h>
@interface ScanViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (nonatomic, retain) BSQRCamera *camera;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self cameraCheck];
}

- (void)cameraCheck
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        // 无相机权限
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self createCamera];
    }
}

- (void)createCamera
{
    CGRect scanArea = CGRectMake(100, 200, 200, 200);
    
    _camera = [[BSQRCamera alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_camera createScaningArea:scanArea];
    __weak typeof(self) wSelf = self;
    _camera.CallBackBlock = ^(NSString *str) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BSRefreshNotifycation object:str];
        [wSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:_camera];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:scanArea];
    imgV.image = [UIImage imageNamed:@"scan_background.png"];
    [self.view addSubview:imgV];

    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:_camera.output.rectOfInterest];
    imgV1.image = [UIImage imageNamed:@"scan_background.png"];
    [self.view addSubview:imgV1];
    
    [self.view bringSubviewToFront:_cancleButton];
    
    [_camera startCamera];
}

- (IBAction)dismiss:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
