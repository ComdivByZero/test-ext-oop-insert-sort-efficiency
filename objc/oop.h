#import <Foundation/Foundation.h>

@protocol Element
@end

@protocol Comparator
-(int)compare:(NSObject<Element> *)a :(NSObject<Element> *)b;
@end

extern void oopSort(NSObject<Element> *arr[], int cnt, NSObject<Comparator> *cmp);
