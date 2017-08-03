//
//  ViewController.m
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/20.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "ViewController.h"
#import "BSQRCodeGenerator.h"
#import "MecardModel.h"
#import "ScanViewController.h"
#import "MJExtension.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *messageLabel;
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
    
    // 辨识二维码图片
    NSArray *arr = [generagor getFeatureInQRImage:_imageView.image];
    NSLog(@"%@",[arr firstObject]);
}

- (IBAction)generateMecard:(UIButton *)sender {
    
    MecardModel *model = [[MecardModel alloc] init];
    model.name = @"老司机";
    model.tel  = @"150 5555 5555";
    model.address = @"上海市浦东新区浦东镇浦东乡浦东村";
    model.nickname = @"芬达";
    model.email = @"saddfjio@139.com";
    model.url  = @"github.hahahahah.com";
    model.birthday = @"1992-02-02";
    model.memo = @"总经理";
    model.orginization = @"上海优驰";
    
    [self analyseQRCodeMessage: [model generateMecardString]];
    return;
    
    BSQRCodeGenerator *generagor = [[BSQRCodeGenerator alloc] init];
    _imageView.image = [generagor generateQRCodeMessage:[model generateMecardString] size:_imageView.frame.size inputCorrectionLevel:InputCorrectionLevel_M];
    _messageLabel.text = [model generateMecardString];
}

// 解析MECARD信息
- (void)analyseQRCodeMessage:(NSString *)codeStr
{
    if ([codeStr hasPrefix:@"MECARD:"]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        NSArray *array = [[codeStr substringFromIndex:7] componentsSeparatedByString:@";"];
        for (NSString *str in array) {
            if (str.length == 0) continue;
            NSRange range = [str rangeOfString:@":"];
            [dictionary setObject:[str substringFromIndex:range.location+range.length] forKey:[str substringToIndex:range.location]];
        }
        MecardModel *model = [MecardModel mj_objectWithKeyValues:dictionary];
    }
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
