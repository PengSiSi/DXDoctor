//
//  RecommendListModel.h
//  DXDoctor
//
//  Created by 思 彭 on 17/3/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface author : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *remarks;

@end

@interface RecommendListModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, assign) NSInteger show_type;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, strong) author *author;

@end
