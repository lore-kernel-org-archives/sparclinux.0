From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 06 Dec 2004 15:16:07 +0000
Subject: strace and restartable syscalls (was Re: ... nanosleep does not
Message-Id: <1102346167.15654.228.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

All,

I have been looking at strace for sparc - a number of things seem broken
so I'm scratching the itch and looking at fixing things (will report on
findings later).

But related to the restart block handling strace gets it wrong and
reports that the restarted system call is SYS_516 (where I would expect
0 - or setup as it used to be called).

13:10:02 nanosleep({100, 0},
[1]+  Stopped                 strace -t ./nanotest32
pingu:~/src# fg
strace -t ./nanotest32
0xeffffc98) = ? ERESTART_RESTARTBLOCK (To be restarted)
13:10:07 --- SIGCONT (Continued) @ 0 (0) ---
13:10:07 syscall_516(0xeffffc98, 0, 0, 0, 0, 0xeffffc30, 0x104f8,
0x104f8, 0x91d02010, 0x153ec, 0x4c388, 0x4c3b0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
13:11:42 fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 0),
...}) = 0

Now this is due to a few lines in the syscall.c file in strace.
Specifically

                        scno = regs.r_g1;
                if (scno = 0) {
                        scno = regs.r_o0;
                        memmove (&regs.r_o0, &regs.r_o1,
7*sizeof(regs.r_o0));
                }

Am I right in thinking that the scno = 0 block is there for Solaris
compatibility. I think that it relates to the block of code in
arch/sparc64/solaris/entry64.S labelled "solaris_sucks".

That gets called if %g1 is zero and moves %i0 to %g1 and all of the
other %i registers down one.

If that is the case then I have the following questions:

1) Does this only apply to the Solaris system calls (i.e. not native
linux ones)

2) Is it safe to use zero for the restart system call? e.g. if nanosleep
gets called via the "solaris sucks" method then restarting it will be a
little tricky.

Richard

On Mon, 2004-12-06 at 13:55, Richard Mortimer wrote:
> On Mon, 2004-12-06 at 05:44, David S. Miller wrote:
> > Good catch Richard.  In fact all restart block handling is hosed
> > on sparc.  It's because of the return from syscall check for
> > error cases, the return value errno comparison is off by one.
> > 
> > This should fix it, and it does for me on sparc64 for your test
> > program.

-- 
richm@oldelvet.org.uk

