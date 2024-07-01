#!/usr/bin/bash

as --fatal-warnings --gstabs -I ./include/ -o build/obj/string.o functions/string.s;
as --fatal-warnings --gstabs -I ./include/ -o build/obj/number.o functions/number.s;
as --fatal-warnings --gstabs -I ./include/ -o build/obj/print.o functions/print.s;
as --fatal-warnings --gstabs -I ./include/ -o build/obj/math.o functions/math.s;
as --fatal-warnings --gstabs -I ./include/ -o build/obj/fizz-as-buzz.o src/fizz-as-buzz.s;

ld -o build/fizz-as-buzz \
build/obj/string.o \
build/obj/number.o \
build/obj/print.o \
build/obj/math.o \
build/obj/fizz-as-buzz.o;
