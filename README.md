# Fizz-[as](https://en.wikipedia.org/wiki/GNU_Assembler)-Buzz

```console
$ docker build . --tag gcc_boiler
$ docker run -it --detach --name fizz-as-buzz -v $(pwd):/home/foo/project gcc_boiler
$ docker exec -it fizz-as-buzz bash
$ ./build.sh; ./build/fizz-as-buzz 100
```

GNU assembler (GNU Binutils for Debian) 2.40
This assembler was configured for a target of `x86_64-linux-gnu'

---

№44 in [programming-challenges](https://github.com/kombarowo/programming-challenges)
