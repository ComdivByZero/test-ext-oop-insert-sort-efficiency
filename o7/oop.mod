MODULE oop;

TYPE
	RElement* = RECORD END;
	Element* = POINTER TO RElement;

	Comparator* = RECORD
		compare: PROCEDURE(c: Comparator; a, b: Element): INTEGER
	END;

	Compare* = PROCEDURE(c: Comparator; a, b: Element): INTEGER;

PROCEDURE cmpInit*(VAR cmp: Comparator; compare: Compare);
BEGIN
	cmp.compare := compare
END cmpInit;

PROCEDURE sort*(VAR arr: ARRAY OF Element; cnt: INTEGER; cmp: Comparator);
VAR i, j: INTEGER;
	a: Element;
BEGIN
	FOR i := 1 TO cnt - 1 DO
		a := arr[i];
		j := i - 1;
		WHILE (j >= 0) & (cmp.compare(cmp, a, arr[j]) < 0) DO
			arr[j + 1] := arr[j];
			DEC(j)
		END;
		arr[j + 1] := a
	END
END sort;

END oop.
