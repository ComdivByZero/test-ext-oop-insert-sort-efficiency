
class Element {
public:
	virtual ~Element() {}
};

class Comparator {
public:
	virtual int compare(Element const *a, Element const *b) const = 0;
};

extern void oopSort(Element *arr[], int cnt, Comparator const *cmp);
