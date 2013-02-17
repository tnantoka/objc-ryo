//
//  common.h
//  test
//
//  Created by Miyake Ryo on 13/02/04.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#ifndef test_common_h
#define test_common_h

#define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#ifdef DEBUG
# define LOG(...) NSLog(__VA_ARGS__)
# define LOG2(fmt,...) NSLog(@"%s:"fmt,__func__,##__VA_ARGS__)
# define LOGSIZE(size) NSLog(@"%s:%u size:%@",__func__,__LINE__,NSStringFromCGSize(size))
# define LOGPOS(pos)   NSLog(@"%s:%u pos:%@",__func__,__LINE__,NSStringFromCGPoint(pos))
# define LOGRECT(rect) NSLog(@"%s:%u rect:%@",__func__,__LINE__,NSStringFromCGRect(rect))
#else
# define LOG(...) ;
# define LOG2(...) ;
# define LOGSIZE(size) ;
# define LOGPOS(pos)   ;
# define LOGRECT(rect) ;
#endif

#endif
