#include "oop.h"

#include <stdlib.h>
#include <stdio.h>
#include <limits.h>


class IntPoint : public Element {
public:
	int x, y;
	IntPoint(int _x, int _y) : x(_x), y(_y) {};
};

class PointComparator : public Comparator {
public:
	int x, y;
	PointComparator(int _x, int _y) : x(_x) , y(_y) {};

	virtual int compare(Element const *ia, Element const *ib) const {
		int ax, ay, bx, by;
		IntPoint const *a, *b;

		a = dynamic_cast<IntPoint const*>(ia);
		b = dynamic_cast<IntPoint const*>(ib);
		ax = a->x - x;
		ay = a->y - y;
		bx = b->x - x;
		by = b->y - y;
		return ax * ax + ay * ay - bx * bx - by * by;
	}
};

static Element** createArray(int cnt) {
	Element **arr;
	int i;
	arr = (Element **)malloc(sizeof(Element *) * cnt);
	if (arr != NULL) {
		i = cnt;
		while (i > 0) {
			i--;
			arr[i] = new IntPoint(cnt - i, cnt - i);
		}
	}
	return arr;
}

static void releaseArray(Element **arr, int cnt) {
	while (cnt > 0) {
		cnt--;
		delete arr[cnt]; 
	}
	free(arr);
}

static void printArray(Element* arr[], int cnt, IntPoint *base) {
	int x, y, ix, iy;
	int i;
	for (i = 0; i < cnt; i++) {
		ix = dynamic_cast<IntPoint *>(arr[i])->x;
		iy = dynamic_cast<IntPoint *>(arr[i])->y;
		x = ix - base->x;
		y = iy - base->y;
		printf("%02d) (%03d:%03d) : %d\n", i, ix, iy, x * x + y * y);
	}
}

int main(int argc, char const *argv[]) {
	int cnt;
	Element **points;
	IntPoint base(0, 0);
	PointComparator cmp(base.x, base.y);
	if (argc > 1) {
		cnt = 20000;
	} else {
		cnt = 20;
	}
	if (cnt > 0) {
		points = createArray(cnt);
		if (points != NULL) {
			if (cnt <= 20) {
				printArray(points, cnt, &base);
				printf("\n");
				oopSort(points, cnt, &cmp);
				printArray(points, cnt, &base);
			} else {
				oopSort(points, cnt, &cmp);
			}
			releaseArray(points, cnt);
		}
	}
	return 0;
}
