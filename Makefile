OPTIM := -O3 -flto

O7C := ../vostok
COUNT := 20000

COMPILE := $(CC) $(OPTIM) -o result/s
COBJC=$(COMPILE).objc objc/*.m
LMAC=-framework Foundation
LLIN=`gnustep-config --objc-flags` -lobjc -lgnustep-base

vpath s.% result

result:
	@mkdir -p result/src/oop
	$(O7C)/result/o7c o7/oop.mod result/oop $(O7C)/singularity/definition
	$(O7C)/result/o7c o7/useoop.mod result/useoop.c o7 $(O7C)/singularity/definition
	cp go/oop.go result/src/oop/ && env GOPATH=`pwd`/result go build -o result/s.go go/useoop.go 
	$(COMPILE).o7 result/*.c $(O7C)/singularity/implementation/*.c -Iresult -I$(O7C)/singularity/implementation
	$(COMPILE).cpp cpp/*.cpp -lstdc++
	if test `uname` = Darwin; then \
		$(COBJC) $(LMAC); \
	else \
		$(COBJC) $(LLIN); \
	fi

time:
	$(foreach v, $(wildcard result/s.*), \
		echo "\n$(v)" && time --portability $(v) $(COUNT);)

size:
	$(foreach v, go cpp o7 objc, echo $(v); cat $(v)/* | wc;)

clean:
	-rm -r result

.PHONY: result time size clean
