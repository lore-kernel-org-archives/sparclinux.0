From: Javier Barrio <coder@fluzo.org>
Date: Sun, 09 Dec 2007 18:55:10 +0000
Subject: Why/when use 0x10 and 0x90 for system calls?
Message-Id: <1d1b2964cccd05bccee60c12f0abf191@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi,

I was doing a little research for myself about system calls on Linux sparc64
and, acording to /usr/include/asm-sparc/traps.h, to execute a system call what
I need to do is to generate a software trap: ta 0x90. Then I coded a little .s
file to test that, and worked:

.global _start

_start:

mov 1, %o0
set string, %o1
mov 0x11, %o2
mov 4, %g1
ta 0x90
mov 0, %o0
mov 1, %g1
ta 0x90

string:
.asciz  "write() invoked!\n"

I did compiled it with as and linked with ld, then executed it:

$ as write.s -o write.o && ld write.o -owrite && ./write
write() invoked!
$

Then I straced it to actually see it working, and something weird happened:

$ strace ./write
execve("./write", ["./write"], [/* 35 vars */]) = 0
syscall: unknown syscall trap 91d02090 000100a8
$

I looked everywhere inside /usr/include and also somewhere inside the linux
kernel 2.6.21 source, focusing on entry.S, where I found nothing.

After hours of frustration I did find on Google people using 'ta 0x10' instead
of 'ta 0x90'. I tested it, worked fine and also I was able to strace it, but I
found that '0x10' nowhere. I don't know where it is defined, hardcoded, or
whatever. None of my two books about Sparc speak about that.

Would anyone here be so kind to explain me that behaviour and when or why use
0x90 or 0x10? Maybe 'ta 0x10' is faster than 'ta 0x90'

Thanks in advance.

--
echo "dpefsAgmv{p/psh" | perl -pe 's/(.)/chr(ord($1)-1)/ge'
GnuPG key ID 0x6D2FF8B5 @ pgp.rediris.es
http://www.fluzo.org/

