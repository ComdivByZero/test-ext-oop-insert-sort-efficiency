package main

import (
	"oop"
	"fmt"
	"os"
)

type (
	IntPoint struct {
		x, y int
	}

	PointComparator struct {
		x, y int
	}
)

func cmp(c *PointComparator, a, b *IntPoint) int {
	ax := a.x - c.x
	ay := a.y - c.y
	bx := b.x - c.x
	by := b.y - c.y
	return ax * ax + ay * ay - bx * bx - by * by
}

func (c *PointComparator) Compare(a, b oop.Element) int {
	return cmp(c, a.(*IntPoint), b.(*IntPoint))
}

func createArray(cnt int) [] oop.Element {
	arr := make([] oop.Element, cnt)
	if arr != nil {
		for cnt > 0 {
			cnt--
			arr[cnt] = &IntPoint{len(arr) - cnt, len(arr) - cnt}
		}
	}
	return arr
}

func printArray(arr [] oop.Element, baseX, baseY int) {
	for i := 0; i < len(arr); i++ {
		ix := arr[i].(*IntPoint).x
		x := ix - baseX
		iy := arr[i].(*IntPoint).y
		y := iy - baseY
		fmt.Printf("%v) (%v:%v) : %v\n", i, ix, iy, x * x + y * y)
	}
}

func main() {
	cnt := 20
	if len(os.Args) > 1 {
		cnt = 20000
	}
	if cnt > 0 {
		points := createArray(cnt)
		if points != nil {
			baseX, baseY := 0, 0
			cmp := PointComparator{baseX, baseY}
			if cnt <= 20 {
				printArray(points, baseX, baseY)
				fmt.Println()
				oop.Sort(points, &cmp)
				printArray(points, baseX, baseY)
			} else {
				oop.Sort(points, &cmp)
			}
		}
	}
}

