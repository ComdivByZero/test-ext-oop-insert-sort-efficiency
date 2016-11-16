package oop

type (
	Element interface {}

	Comparator interface {
		Compare(a, b Element) int
	}
)

func Sort(arr [] Element, cmp Comparator) {
	for i := 1; i < len(arr); i++ {
		a := arr[i]
		j := i - 1
		for (j >= 0) && (cmp.Compare(a, arr[j]) < 0) {
			arr[j + 1] = arr[j]
			j--
		}
		arr[j + 1] = a
	}
}
