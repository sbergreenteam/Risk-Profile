//
//  FinalCell.m
//  Risk Profile
//
//  Created by Ikhtiyor Nurmatov on 2019-11-16.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

#import "FinalCell.h"

@implementation FinalCell
    
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            self.imageView = [[UIImageView alloc]init];
            self.imageView.frame = CGRectMake(26, 27, 90, 90);
            
        
            [self.viewForFirstBaselineLayout addSubview:self.imageView];
            
            self.viewForFirstBaselineLayout.layer.masksToBounds = YES;
            self.viewForFirstBaselineLayout.layer.cornerRadius = 8.0f;
    }
    return self;
}
@end
