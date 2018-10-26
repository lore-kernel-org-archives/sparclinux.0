From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2018 03:29:54 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20181025.202954.554322425222522754.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2018 16:39:22 -0700 (PDT)

> This is a 64-bit ELF binary so my guess is setup_rt_frame().
> 
> I put some debugging in and I guessed wrong:
> 
> [   40.366945] [tweaklib2:428]: fault_in_user_windows() copy failed
> 
> Something definitely corrupted the stack and/or frame pointer in this
> code.

What this amounts to is actually a very simple program:

davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ readelf -h tweaklib2
 ...
  Entry point address:               0x1003d0

Entry point 0x1003d0, what's that:

davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ objdump -d tweaklib2 | grep -A 1 1003d0
00000000001003d0 <SI_PRC_$$__FPC_DYNAMIC_PROC_START>:
  1003d0:       81 c3 e0 08     retl
  1003d4:       01 00 00 00     nop

An entry point which simply returns.  So this program does nothing,
main never gets called, we just return to the dynamic linker code that
jumps to the program's entry point which isn't expected.

So the test case is simply:

davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ cat test.s
        .text
        .align 4
        .globl _start
_start: retl
        nop
davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ gcc -nostdlib -o test test.s
davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ ./test
Segmentation fault
davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ 

and nothing more.

So what happens when you return from _start like this?  It ends up
looping, adjusting the stack pointer up by 48 bytes every iteration.
Eventually we push the stack pointer past the end of the stack mmap
area and crash.

The loop is:

davem@salty:/opt/davem/src/GIT/CRASH/kernel-crash-test$ gdb ./test
 ...
(gdb) b *0x0000010000000290
Breakpoint 1 at 0x10000000290
(gdb) display/i $pc
1: x/i $pc
<error: No registers.>
(gdb) run
Starting program: /opt/davem/src/GIT/CRASH/kernel-crash-test/test

Breakpoint 1, 0x0000010000000290 in _start ()
1: x/i $pc
=> 0x10000000290 <_start+4>:    nop
(gdb) stepi
0xfff0000100001550 in ?? ()
1: x/i $pc
=> 0xfff0000100001550:  sethi  %hi(0x113000), %g1
(gdb) 
0xfff0000100001554 in ?? ()
1: x/i $pc
=> 0xfff0000100001554:  xor  %g1, -572, %g1
(gdb) 
0xfff0000100001558 in ?? ()
1: x/i $pc
=> 0xfff0000100001558:  add  %l7, %g1, %g1
(gdb) 
0xfff000010000155c in ?? ()
1: x/i $pc
=> 0xfff000010000155c:  jmp  %l0
   0xfff0000100001560:  add  %sp, 0x30, %sp
(gdb) 
0xfff0000100001560 in ?? ()
1: x/i $pc
=> 0xfff0000100001560:  add  %sp, 0x30, %sp
(gdb) 
0x000001000000028c in _start () 
1: x/i $pc 
=> 0x1000000028c <_start>:      retl
   0x10000000290 <_start+4>:    nop 
(gdb) 

And that's how we loop forever.

It should not crash the machine and here with an upstream kernel it does not for me.
