

shrinkelf: shrinkelf.c
	gcc -o shrinkelf shrinkelf.c


withminilib: shrinkelf.c
	make -f minilib.make


