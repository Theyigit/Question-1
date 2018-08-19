//
//  main.m
//  Question-1
//
//  Created by Yigit Yilmaz on 16.08.2018.
//  Copyright © 2018 Yigit Yilmaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorClass:NSObject

// method declaration
- (NSArray*)find2ElementsAtleastPresentIn2Arrays:(NSArray*)aList b:(NSArray*)bList c:(NSArray*)cList;

@end

@implementation CalculatorClass

// method returning the result array
- (NSMutableArray*)find2ElementsAtleastPresentIn2Arrays:(NSArray*)aList b:(NSArray*)bList c:(NSArray*)cList {

    NSMutableArray *result = [[NSMutableArray alloc] init];
    bList = [bList sortedArrayUsingSelector:@selector(compare:)];
    aList = [aList sortedArrayUsingSelector:@selector(compare:)];
    cList = [cList sortedArrayUsingSelector:@selector(compare:)];

    NSRange bSearchRange = NSMakeRange(0, [bList count]);
    NSRange cSearchRange = NSMakeRange(0, [cList count]);

    for (int i = 0; i < aList.count; i++) {
        NSUInteger findIndex = [bList indexOfObject:aList[i]
                                            inSortedRange:bSearchRange
                                            options:NSBinarySearchingFirstEqual
                                            usingComparator:^(id obj1, id obj2)
                                    {
                                        return [obj1 compare:obj2];
                                    }];
        findIndex = (int) findIndex;
        if (findIndex != -1) {
            [result addObject:bList[findIndex]];
        }

        findIndex = [cList indexOfObject:aList[i]
                                      inSortedRange:cSearchRange
                                            options:NSBinarySearchingFirstEqual
                                    usingComparator:^(id obj1, id obj2)
                                {
                                    return [obj1 compare:obj2];
                                }];
        findIndex = (int) findIndex;
        if (findIndex != -1) {
            [result addObject:cList[findIndex]];
        }

   }

    for (int i = 0; i < bList.count; i++) {
        NSUInteger findIndex = [cList indexOfObject:bList[i]
                                     inSortedRange:cSearchRange
                                           options:NSBinarySearchingFirstEqual
                                   usingComparator:^(id obj1, id obj2)
                               {
                                   return [obj1 compare:obj2];
                               }];
        findIndex = (int) findIndex;
        if (findIndex != -1) {
            [result addObject:cList[findIndex]];
        }
    }

    return [result sortedArrayUsingSelector:@selector(compare:)];
}

@end

int main(int argc, const char * argv[]) {

    // Definitions of sample arrays, changable as you want
    NSArray *a = @[@1,@3,@4,@5];
    NSArray *b = @[@-1,@3,@0,@9];
    NSArray *c = @[@0,@31,@32,@22,@6];

    @autoreleasepool {

        CalculatorClass *calculatorObject = [[CalculatorClass alloc]init];

        NSLog(@"result: \n%@",  [calculatorObject find2ElementsAtleastPresentIn2Arrays:a b:b c:c]);
    }

    return 0;
}
