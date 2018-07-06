//
//  HolidayMolde.m
//  
//
//  Created by lyngame on 2018/3/8.
//

#import "HolidayMolde.h"

@implementation HolidayMolde
//-(instancetype)setHoliday:(NSString*)string{
////    self = [super init];
////    if (self) {
////        [self setValuesForKeysWithDictionary:dic];
////        //创建一个可变数组加载soldarray
////        NSMutableArray *soldArray = [NSMutableArray array];
////        for (NSDictionary *dic in self.messageArray) {
////            SOldModel *model = [[SOldModel alloc]initWithDic:dic];
////            [soldArray addObject:model];
////        }
////        self.messageArray = soldArray;
////    }
//    return self;
//}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.Holiday forKey:@"Holiday"];
    [encoder encodeObject:self.Hname forKey:@"Hname"];

}

/**
 *  每次从文件中恢复(解码)对象时，都会调用这个方法。
 *  一般在这个方法里面指定如何解码文件中的数据为对象的实例变量，
 *  可以使用decodeObject:forKey:方法解码实例变量
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    self.Holiday = [decoder decodeObjectForKey:@"Holiday"];
    self.Hname = [decoder decodeObjectForKey:@"Hname"];

    return self;
}



@end
