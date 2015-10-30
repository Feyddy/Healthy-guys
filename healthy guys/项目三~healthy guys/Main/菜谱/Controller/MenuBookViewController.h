//
//  MenuBookViewController.h
//  项目三_Healthyguns
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuBookViewController : BaseViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic,assign) NSInteger listID;
@end
