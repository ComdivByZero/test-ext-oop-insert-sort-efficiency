MODULE useoop;

IMPORT oop, Out, CLI;

TYPE
	IntPoint = POINTER TO RECORD(oop.RElement)
		x, y: INTEGER
	END;

	PointComparator = RECORD(oop.Comparator)
		x, y: INTEGER
	END;

	PointArray = POINTER TO RECORD
		arr: ARRAY 40000 OF oop.Element;
		cnt: INTEGER
	END;

PROCEDURE NewPoint(x, y: INTEGER): IntPoint;
VAR p: IntPoint;
BEGIN
	NEW(p);
	IF p # NIL THEN
		p.x := x;
		p.y := y
	END
RETURN p
END NewPoint;

PROCEDURE compare(c: oop.Comparator; a, b: oop.Element): INTEGER;
	PROCEDURE cmp(c: PointComparator; a, b: IntPoint): INTEGER;
	VAR ax, ay, bx, by: INTEGER;
	BEGIN
		ax := a.x - c.x;
		ay := a.y - c.y;
		bx := b.x - c.x;
		by := b.y - c.y
	RETURN ax * ax + ay * ay - bx * bx - by * by
	END cmp;
RETURN cmp(c(PointComparator), a(IntPoint), b(IntPoint))
END compare;

PROCEDURE cmpInit(VAR cmp: PointComparator; x, y: INTEGER);
BEGIN
	oop.cmpInit(cmp, compare);
	cmp.x := x;
	cmp.y := y
END cmpInit;

PROCEDURE createArray(cnt: INTEGER): PointArray;
VAR arr: PointArray;
BEGIN
	NEW(arr);
	IF arr # NIL THEN
		arr.cnt := cnt;
		WHILE cnt > 0 DO
			DEC(cnt);
			arr.arr[cnt] := NewPoint(arr.cnt - cnt, arr.cnt - cnt)
		END
	END
RETURN arr
END createArray;

PROCEDURE printArray(arr: PointArray; baseX, baseY: INTEGER);
VAR i, x, y, ix, iy: INTEGER;
BEGIN
	FOR i := 0 TO arr.cnt - 1 DO
		ix := arr.arr[i](IntPoint).x;
		x := ix - baseX;
		iy := arr.arr[i](IntPoint).y;
		y := iy - baseY;
		Out.Int(i, 2); Out.String(") ("); Out.Int(ix, 3); Out.String(":");
		Out.Int(iy, 3); Out.String(") : "); Out.Int(x * x + y * y, 0);
		Out.Ln
	END
END printArray;

PROCEDURE main*;
VAR cnt: INTEGER;
	points: PointArray;
	baseX, baseY: INTEGER;
	cmp: PointComparator;
BEGIN
	baseX := 0; baseY := 0;
	cmpInit(cmp, baseX, baseY);
	IF CLI.count > 1 THEN
		cnt := 20000
	ELSE
		cnt := 20
	END;
	IF cnt > 0 THEN
		points := createArray(cnt);
		IF points # NIL THEN
			IF cnt <= 20 THEN
				printArray(points, baseX, baseY);
				Out.Ln;
				oop.sort(points.arr, points.cnt, cmp);
				printArray(points, baseX, baseY)
			ELSE
				oop.sort(points.arr, points.cnt, cmp)
			END
		END
	END
END main;

BEGIN
	main
END useoop.
