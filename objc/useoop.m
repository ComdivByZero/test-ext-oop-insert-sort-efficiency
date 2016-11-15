#import "oop.h"

#import <stdlib.h>
#import <stdio.h>

@interface IntPoint: NSObject<Element> {
@public
	int x, y;
}

+create:(int)x :(int)y;

@end

@implementation IntPoint 

+create:(int)x :(int)y {
	IntPoint *p = [[IntPoint alloc] init];
	if (p != nil) {
		p->x = x;
		p->y = y;
	} 
	return p;
}

@end

static Class IntPointClass;

@interface PointComparator: NSObject<Comparator> {
@public
	int x, y;
}

+ create:(int)x :(int)y;

@end;

@implementation PointComparator

+ create:(int)x :(int)y; {
	PointComparator *cmp = [[PointComparator alloc] init];
	if (cmp != nil) {
		cmp->x = x;
		cmp->y = y;
	}
	return cmp;
}

-(int)compare:(NSObject<Element> *)ia :(NSObject<Element> *)ib {
	int ax, ay, bx, by;
	IntPoint *a, *b;

	assert([ia isKindOfClass:IntPointClass]);
	assert([ib isKindOfClass:IntPointClass]);
	a = (IntPoint *)ia;
	b = (IntPoint *)ib;
	ax = a->x - x;
	ay = a->y - y;
	bx = b->x - x;
	by = b->y - y;
	return ax * ax + ay * ay - bx * bx - by * by;
}

@end

static NSObject<Element>** createArray(int cnt) {
	NSObject<Element> **arr;
	int i;
	arr = (IntPoint **)malloc(sizeof(NSObject<Element> *) * cnt);
	if (arr != NULL) {
		i = cnt;
		while (i > 0) {
			i--;
			arr[i] = [IntPoint create:cnt - i :cnt - i];
		}
	}
	return arr;
}

static void releaseArray(NSObject<Element> **arr, int cnt) {
	while (cnt > 0) {
		cnt--;
		[arr[cnt] release];
	}
	free(arr);
}

static void printArray(NSObject<Element>* arr[], int cnt, IntPoint *base) {
	int x, y, ix, iy;
	int i;
	for (i = 0; i < cnt; i++) {
		assert([arr[i] isKindOfClass:IntPointClass]);
		ix = ((IntPoint *)arr[i])->x;
		iy = ((IntPoint *)arr[i])->y;
		x = ix - base->x;
		y = iy - base->y;
		printf("%02d) (%03d:%03d) : %d\n", i, ix, iy, x * x + y * y);
	}
}

int main(int argc, char const *argv[]) {
	int cnt;
	NSObject<Element> **points;
	IntPoint *base;
	PointComparator *cmp;
	if (argc > 1) {
		cnt = 20000;
	} else {
		cnt = 20;
	}
	if (cnt > 0) {
		IntPointClass = [IntPoint class];
		points = createArray(cnt);
		if (points != NULL) {
			cmp = [PointComparator create:0 :0];
			if (cmp != nil) {
				if (cnt <= 20) {
					base = [IntPoint create:cmp->x :cmp->y];
					printArray(points, cnt, base);
					printf("\n");
					oopSort(points, cnt, cmp);
					printArray(points, cnt, base);
					[base release];
				} else {
					oopSort(points, cnt, cmp);
				}
				[cmp release];
			}
			releaseArray(points, cnt);
		}
	}
	return 0;
}
