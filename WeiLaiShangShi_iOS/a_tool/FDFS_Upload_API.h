//
//  FDFS_Upload_API.h
//  Fast_OC_Demo_1
//
//  Created by linxiang on 2017/10/16.
//  Copyright © 2017年 minxing. All rights reserved.
//

#ifndef FDFS_Upload_API_h
#define FDFS_Upload_API_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "fdfs_client.h"
#include "logger.h"


#ifdef __cplusplus
extern "C" {
#endif
    int fdfs_upload_by_filename(const char *filename,char *file_id,const char *clientName);
    
#ifdef __cplusplus
}
#endif


#endif /* FDFS_Upload_API_h */


//int retn = 0;
//// 配置文件路径
//const char *clientname = [[[NSBundle mainBundle] pathForResource:@"client" ofType:@"conf"] UTF8String];
////要上传的文件路径
//const char *filename  = [[[NSBundle mainBundle] pathForResource:@"123" ofType:@"jpg"] UTF8String];
//
//
//char file_id[500] = {0};
//retn = fdfs_upload_by_filename(filename,file_id,clientname);
//if(0 != retn)
//{
//    printf("upload_by_filename err,errno = %d\n",retn);
//}
//printf("file_id = %s\n",file_id);
