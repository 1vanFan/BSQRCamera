//
//  ViewController.m
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/20.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "ViewController.h"
#import "BSQRCodeGenerator.h"
#import "ScanViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLabel:) name:BSRefreshNotifycation object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)generateButtonClick:(UIButton *)sender {
    BSQRCodeGenerator *generagor = [[BSQRCodeGenerator alloc] init];
    _imageView.image = [generagor generateQRCodeMessage:_textField.text size:_imageView.frame.size inputCorrectionLevel:InputCorrectionLevel_L];
    
    //辨识二维码图片
    NSArray *arr = [generagor getFeatureInQRImage:_imageView.image];
    NSLog(@"%@",[arr firstObject]);
}

- (void)refreshLabel:(NSNotification*)nofity
{
    _messageLabel.text = (NSString *)nofity.object;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
