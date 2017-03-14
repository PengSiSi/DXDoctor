//
//  DetailViewController.m
//  Ssdfz
//
//  Created by 王楠 on 16/1/22.
//  Copyright © 2016年 Combanc. All rights reserved.
//  新闻详情和通知详情会重用到的类

#import "DetailViewController.h"

@interface DetailViewController()<UIWebViewDelegate>


@end
@implementation DetailViewController

#pragma mark - LifeCycle
-(void)viewDidLoad{
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    //    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - Setter
-(void)setDataDic:(NSDictionary *)dataDic{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
//    [html appendString:@"<style>img{max-width:320px !important;}</style>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"Details.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self touchBody:dataDic]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}

#pragma mark - 将数据拆分
-(NSString *)touchBody:(NSDictionary *)dic{
    /*
     {
     NodeID = 90;
     AddDate = 2016/1/11 10:08:00;
     FileUrl = ;
     AddUserName = gxh0402;
     ImgUrl = <null>;
     Content = <p style="TEXT-ALIGN: center">
     <strong><span style="FONT-FAMILY: 黑体; FONT-SIZE: 56px">公&nbsp;&nbsp; 示</span></strong></p>
     <p>
     <span style="FONT-FAMILY: 宋体; FONT-SIZE: 29px">&nbsp;</span></p>
     <p style="TEXT-ALIGN: left; LINE-HEIGHT: 37px; TEXT-INDENT: 43px">
     <span style="FONT-SIZE: 21px"><span style="FONT-FAMILY: 宋体">根据关于印发〈海淀区幼儿园、中小学、中等职业学校骨干教师、带头人选拔和管理暂行办法〉的通知》（海教工发〔2006〕12号）和《海淀区教育委员会关于开展2015年海淀区幼儿园中小学中等职业学校区级带头人区级骨干教师评选工作的通知》（海教发〔2015〕48号）要求，经校初级评审委员会评审，拟推荐郝艳丽参加2015年区级教育科研带头人评选。现对推荐人选进行公示：</span></span></p>
     <p style="TEXT-ALIGN: left; LINE-HEIGHT: 41px; TEXT-INDENT: 43px">
     <span style="FONT-SIZE: 21px"><span style="FONT-FAMILY: 宋体">&nbsp;</span></span></p>
     <p style="TEXT-ALIGN: left; LINE-HEIGHT: 41px; TEXT-INDENT: 43px">
     <span style="FONT-FAMILY: 宋体"><strong><span style="FONT-SIZE: 21px">郝艳丽</span></strong><span style="FONT-SIZE: 21px">，博士研究生，教龄4年，2014.05北京市教育学会</span><span style="FONT-FAMILY: 宋体; FONT-SIZE: 21px">&ldquo;</span><span style="FONT-SIZE: 21px">十二五</span><span style="FONT-FAMILY: 宋体; FONT-SIZE: 21px">&rdquo;</span><span style="FONT-SIZE: 21px">教育科研课题研究成果一等奖；2015.08 北京市第七届&ldquo;京研杯</span><span style="FONT-FAMILY: 宋体; FONT-SIZE: 21px">&rdquo;</span><span style="FONT-SIZE: 21px">教育教学研究成果二等奖。</span></span></p>
     <p style="TEXT-ALIGN: left; LINE-HEIGHT: 41px; TEXT-INDENT: 43px">
     <span style="FONT-SIZE: 21px"><span style="FONT-FAMILY: 宋体">&nbsp;</span></span></p>
     <p style="TEXT-ALIGN: left; LINE-HEIGHT: 41px; TEXT-INDENT: 43px">
     <span style="FONT-SIZE: 21px"><span style="FONT-FAMILY: 宋体">公示期从1月11日起至1月15日止。公示期内，如有意见或异议，可通过下列渠道反映。</span></span></p>
     <p style="TEXT-INDENT: 43px">
     <span style="FONT-SIZE: 21px"><span style="FONT-FAMILY: 宋体">电话：68900407&nbsp; </span></span></p>
     <p style="TEXT-INDENT: 43px">
     <span style="FONT-SIZE: 21px"><span style="FONT-FAMILY: 宋体">&nbsp;</span></span></p>
     <p style="TEXT-INDENT: 348px">
     <span style="COLOR: black; FONT-SIZE: 19px"><span style="FONT-FAMILY: 宋体">首都师范大学附属中学</span></span></p>
     <p>
     <a name="_GoBack"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="FONT-FAMILY: 宋体"><span style="FONT-FAMILY: 仿宋_GB2312; FONT-SIZE: 21px">2016</span><span style="FONT-FAMILY: 仿宋_GB2312; FONT-SIZE: 21px">年1月11日</span></span></p>
     ;
     ReceiveUser = (
     zlp1213=true,
     jxz1435,
     wjh1440,
     lxr1441,
     lxx1446,
     );
     Title = 区教育科研带头人 公示;
     Hits = 74;
     PublishmentSystemID = 1;
     ID = 7334;
     }

     */
//    NSLog(@"dic--   %@",dic);
    //标题
    NSString *title = dic[@"Title"];
    //时间
    NSString *time = [NSString stringWithFormat:@"%@",dic[@"AddDate"]];
    NSString *bumen = [NSString stringWithFormat:@"%@",dic[@"department"]];
    
    NSString *hits;
    
    if ([dic[@"Hits"] isEqualToString:@""]) {
        
        //浏览次数
        NSString *hitsNull = [NSString stringWithFormat:@"%@",@""];
        hits = hitsNull;
    }
    else{
        //浏览次数
        NSString *hitsNotNull = [NSString stringWithFormat:@"浏览：%@次",dic[@"Hits"]];
        hits = hitsNotNull;
    }
    
    NSMutableString * body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",title];
    [body appendFormat:@"<div class=\"time\">%@ &nbsp %@ &nbsp %@</div>",time,bumen,hits];
    //内容
    NSString *str = [NSString stringWithFormat:@"%@",dic[@"Content"]];
    if (str.length > 2) {
        str = [str stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://oa.tjtdxy.cn:8080" options:NSLiteralSearch range:NSMakeRange(0, str.length - 1)];
        
        str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, str.length - 1)];
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'combanc:src=' +this.src;"
        "};";
        
        /*
         [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
         
         */
        str = [str stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img onload=\"%@\" style= height=\"250px\"; width=\"100%%\"",onload]];
        
        //  &amp;   &
    }
    
//    NSLog(@"str--   \n%@",str);
    [body appendFormat:@"<div class=\"contentText\">%@ </div>",str];
//    [body appendString:str];
    
    return body;
}



@end
