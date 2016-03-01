//
//  ViewController.m
//  network
//
//  Created by 极客学院 on 16/2/29.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,copy)NSString*strImageUrl;
@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (weak, nonatomic) IBOutlet UIButton *icon1;

@property(nonatomic,assign)CGRect oldRect;
@end

@implementation ViewController
- (IBAction)zoom:(id)sender {
    
    int iWidth = [UIScreen mainScreen].bounds.size.width;
    
    if (iWidth == self.icon1.frame.size.width +10) {
        self.icon1.frame = self.oldRect;
    }
    else
    {
        self.oldRect = self.icon1.frame;
        
        CGRect rect = CGRectMake(10, 10, iWidth -10, iWidth- 10);
        self.icon1.frame = rect;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 定义一个url地址
    NSURL*url = [NSURL URLWithString:@"https://hellobj.sinaapp.com/test.php"];
    
    // 2. 定义一个request请求对象
    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
    
    // 3. 建立连接
    NSURLConnection*connet = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"连接失败%@",error);
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"收到服务器响应 %@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    // 4. 解析数据
    NSDictionary*dict  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    self.strImageUrl = [dict objectForKey:@"headimgurl"];
    NSLog(@"收到数据 头像地址为：%@",self.strImageUrl);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"传输数据完成 %@",connection);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIImage*image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.strImageUrl]]];
    
    self.pic.image = image;
    
    [self.icon1 setImage:image forState:UIControlStateNormal];
}

@end
