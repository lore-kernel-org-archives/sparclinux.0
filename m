From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 23 Nov 2006 22:29:53 +0000
Subject: Re: Sparc32 SMP
Message-Id: <456620E1.5070809@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607130208320.4657-300000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607130208320.4657-300000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	This Oops is reproductible. I have decoded the Oops:

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Nov 23 14:26:47 hilbert kernel: Unable to handle kernel NULL pointer 
dereference
Nov 23 14:26:48 hilbert kernel: tsk->{mm,active_mm}->context = 00005058
Nov 23 14:26:48 hilbert kernel: tsk->{mm,active_mm}->pgd = fc12d000
Nov 23 14:26:48 hilbert kernel:               \|/ ____ \|/
Nov 23 14:26:48 hilbert kernel:               "@'/ ,. \`@"
Nov 23 14:26:48 hilbert kernel:               /_| \__/ |_\
Nov 23 14:26:48 hilbert kernel:                  \__U_/
Nov 23 14:26:48 hilbert kernel: tar(13387): Oops [#1]
Nov 23 14:26:48 hilbert kernel: PSR: 400000c2 PC: f008bd8c NPC: f008bd90 
Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Nov 23 14:26:48 hilbert kernel: PC: <pipe_readv+0xac/0x440>
Nov 23 14:26:48 hilbert kernel: Caller[f008c140]: pipe_read+0x20/0x28
Nov 23 14:26:48 hilbert kernel: Caller[f007dee8]: vfs_read+0xa0/0x16c
Nov 23 14:26:48 hilbert kernel: Caller[f007eb38]: sys_read+0x38/0x64
Nov 23 14:26:48 hilbert kernel: Caller[f0015a3c]: 
syscall_is_too_hard+0x3c/0x40
Nov 23 14:26:48 hilbert kernel: Caller[0003df90]: 0x3df98
Nov 23 14:26:49 hilbert kernel: Instruction DUMP: 1a800003  fa04a00c 
a810001b <c207600c> 90100013  9fc04000  92100012  80a22000  128000b9


 >>PC;  f008bd8c <pipe_readv+2f8/4d4>   <==
Trace; f008c140 <do_pipe+158/28c>
Trace; f007dee8 <vfs_readv+6c/70>
Trace; f007eb38 <__fput+8c/1b0>
Trace; f0015a3c <linux_sparc_syscall+0/18>
Trace; 0003df90 Before first symbol

Code;  f008bd80 <pipe_readv+2ec/4d4>
00000000 <_PC>:
Code;  f008bd80 <pipe_readv+2ec/4d4>
    0:   1a 80 00 03       bcc  c <_PC+0xc>
Code;  f008bd84 <pipe_readv+2f0/4d4>
    4:   fa 04 a0 0c       ld  [ %l2 + 0xc ], %i5
Code;  f008bd88 <pipe_readv+2f4/4d4>
    8:   a8 10 00 1b       mov  %i3, %l4
Code;  f008bd8c <pipe_readv+2f8/4d4>   <==    c:   c2 07 60 0c       ld  [ %i5 + 0xc ], %g1   <==Code;  f008bd90 <pipe_readv+2fc/4d4>
   10:   90 10 00 13       mov  %l3, %o0
Code;  f008bd94 <pipe_readv+300/4d4>
   14:   9f c0 40 00       call  %g1
Code;  f008bd98 <pipe_readv+304/4d4>
   18:   92 10 00 12       mov  %l2, %o1
Code;  f008bd9c <pipe_readv+308/4d4>
   1c:   80 a2 20 00       cmp  %o0, 0
Code;  f008bda0 <pipe_readv+30c/4d4>
   20:   12 80 00 b9       bne  304 <_PC+0x304>
Code;  f008bda4 <pipe_readv+310/4d4>
   24:   00 00 00 00       unimp  0


1 error issued.  Results may not be reliable.
hilbert:/var/log#

	I don't understand the last message... Any idea ?

	Regards,

	JKB
