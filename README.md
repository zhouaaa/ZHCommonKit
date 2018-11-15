# ZHCommonKit
平常项目常用的kit



#ZHNetClient
可在appDelegate中初始化

 [NetClient initWithBasicURL:Basic_url
                       pageSize:1
                   pageKeywords:@"p"
               pageSizeKeywords:@"num"
              tokenHeadKeywords:@"Authorization"
          deiviceClientKeywords:@"Device"];
    //可添加各种请求头
    AFHTTPRequestSerializer *tempRequestSerializer = [NetClient sharedManager].requestSerializer;
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [tempRequestSerializer setValue:uuid forHTTPHeaderField:@"UUID"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [tempRequestSerializer setValue:app_Version forHTTPHeaderField:@"Version"];

    [tempRequestSerializer setValue:[Prefence shared].Session_id forHTTPHeaderField:@"Session_id"];
    
    [tempRequestSerializer setValue:@"iOS" forHTTPHeaderField:@"Device"];
    
eg：
 [ZHNetClient initWithBasicURL:nil isOpenLog:YES];
    ZHNetRequest *request = [[ZHNetRequest alloc] initWithRelativeURLString:@"https://www.apiopen.top/novelApi" success:^(id data) {
        
    } fail:^(NSError *error) {
        
    }];
    [request postData];
