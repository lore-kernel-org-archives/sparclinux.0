From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 16 Oct 2011 17:07:38 +0000
Subject: Re: longjmp question
Message-Id: <20111016170738.GA5184@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 14, 2011 at 07:26:50PM -0400, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sat, 15 Oct 2011 00:06:53 +0100
> 
> > Replacing "flushw" with "ta 0x03" makes the problem go away. What is 
> > the difference between the two? I would naively think that the effect 
> > of both should be saving register windows on the stack, allocating a
> > new stack frame for each of them, so fp would get adjusted in either 
> > case. Then I would expect that the correct fix would be to indicate to 
> > the compiler that flushw is clobbering fp/sp registers, so it cannot 
> > rely on their contents afterwards. The fact that using "ta 0x03" fixes 
> > it makes me feel lost again :-).
> 
> Taking a trap has a side effect, in that the %g* and %o* registers
> will be saved and restored by the trap entry and exit respectively.
> 
> Trap entry also grabs a register window (for the kernel), which
> is restored from on trap exit.
> 
> The register window flush is performed between this trap statesave and
> restore.
> 
> Furthermore, it also means that the current register window will be
> saved by the "ta 0x03" case.
> 
> This is probably why certain gdb breakpoints also make the problem go
> away.
> 
> Essentially, "ta 0x03" is kind of like:
> 
> 	save	%sp, -WHATEVER, %sp
> 	flushw
> 	restore
> 
> so it will restore one more register window than an actual 'flushw'
> in userspace would.
> 
> I'm starting to become convinced that if you look at the stack
> backtrace at the time of the flushw done by ruby, you'll see that
> there are multiple stack frames using the same memory regions.
> 
> I'll try to look at this more closely myself, especially since you've
> given me excellent tips on how to reproduce this and run it under gdb,
> but I'm currently fighting a gcc bug which I want to clear away first.
> 
> Thanks!

Thank you!

In the meantime, I've recognized that I can store fp before and after 
flushw in %l0 and %l1, and memcpy is not allowed to touch them. After 
changing the code to

  mov %fp, %l0
  flushw
  mov %fp, %l1

I've found that value of %fp does not change as a result of flushw 
after all, even in the case when it crashes later. So, as far as I can 
tell, memcpy is receiving correct arguments. Furthermore, looking at 
memcpy implementation (backed by __memcpy_ultra3 in my case), I see 
that it's likely (I've not examined all possible paths) that before it 
branches to 'out', o1 will contain the current source address and 
o3 will contain the distance between source and destination. I checked 
these values after our memcpy call, and they are consistent, i.e. o1 
points at the end of source region, and o3 is the difference between 
the end of source and destination regions. That made me wonder whether 
we do copy at least part of the data, and it appears that only the 
beginning of the memory regions is not copied correctly. Here's an 
example dump of the first 32 bytes in the crashing case after memcpy:

(gdb) x/32xw cont->machine_stack_src
0xffffc96c:     0x00000001      0xffffc9e0      0xffffc9e0      0x00000000
0xffffc97c:     0x00000000      0x00000000      0x00000000      0x00000000
0xffffc98c:     0xf7fb1cb8      0xffffca40      0x00003910      0x00000000
0xffffc99c:     0x00022b88      0x00022b88      0x000001b5      0xffffc9e0
0xffffc9ac:     0xf7f4d7a4      0x00000000      0xf7ffc4d0      0xf7decc32
0xffffc9bc:     0xf7de8888      0xf7de46c8      0xffffc9f8      0x00000000
0xffffc9cc:     0x00000001      0xffffffff      0x001d6620      0x00047508
0xffffc9dc:     0x00047508      0x00000000      0x00000000      0x00000000
(gdb) x/32xw cont->machine_stack
0x1d6938:       0x00000001      0x00000000      0x00000000      0x00000000
0x1d6948:       0xf7fb1cb8      0x000c8170      0x00000001      0x000c76a9
0x1d6958:       0xffffcc94      0x00000001      0x000c76a8      0xffffcc30
0x1d6968:       0xf7ebc03c      0x00000000      0x00000000      0x00000005
0x1d6978:       0x000001db      0x00000000      0xf7ffc4d0      0xf7decc32
0x1d6988:       0xf7de8888      0xf7de46c8      0xffffc9f8      0x00000000
0x1d6998:       0x00000001      0xffffffff      0x001d6620      0x00047508
0x1d69a8:       0x00047508      0x00000000      0x00000000      0x00000000

As you can see, the first 17 words of the memory regions differ, but 
after the data appears to be copied correctly (total amount of data 
copied in this case is 437 words).

Assuming that the analysis is correct, and memcpy does receive correct 
arguments, it might be a bug in __memcpy_ultra3 (which would be very 
exciting :-). If you are using an UltraSparc III machine as well, and 
could try it on a different architecture, I would be a very interested 
in the result.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
