//
//  Wine.h
//
//  Created by wgarbaya on 01/01/13.
//  Copyright (c) 2012 Walid Garbaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wine : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *domaine;
@property (nonatomic, strong) NSString *apropos;
@property (nonatomic, strong) NSString *image;
@property (nonatomic) NSInteger nombre;
@end
