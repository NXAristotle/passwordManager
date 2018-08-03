//
//  UIImage+KIM.h
//
//
//  Created by linyibin on 14/12/18.
//  Copyright (c) 2014年 NXAristotle. All rights reserved.
//

#import "UIImage+KIM.h"

@implementation UIImage (KIM)


+(UIImage *)resizingImage:(NSString *)named
{
  
        UIImage *normol = [UIImage imageNamed:named];
        CGFloat w = normol.size.width*0.5;
        CGFloat h = normol.size.height*0.5;
    
        return [normol stretchableImageWithLeftCapWidth:w topCapHeight:h];

}
@end
