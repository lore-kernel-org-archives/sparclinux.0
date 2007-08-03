From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Fri, 03 Aug 2007 19:43:17 +0000
Subject: Re: Kernel compile errors
Message-Id: <Pine.LNX.4.61.0708031925450.22041@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <46B3345F.7060004@gmail.com>
In-Reply-To: <46B3345F.7060004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sunil,

There are three things that will help you, if you are building for a 
Sparc32 system (sun4c, sun4d or sun4m).

1) Sparc32 Floppy support can't be built as a module at present. The 
problem is currently being worked on.

2) Make as much as posible as modules, only include the minimum of 
debugging facilities that you can get away with and don't build any code 
that you do not need. There is a kernel size limitation on sparc32 so you 
need to minimise the size of your kernel or you will have difficulty in 
getting it to boot :).

3) There are a number of fixes required for Sparc32. I recommend getting 
the latest kernel from linux/kernel/git/davem/sparc-2.6.git to get all the 
latest sparc32/64 fixes.

I currently use linux/kernel/git/torvalds/linux-2.6.git. This is up to 
date for sparc32 fixes that I am aware of (Wednesday's sun4c test was 
fine).

One of the problems with the rapid development of the Linux kernel is that 
the various maintaines have a hard time trying to ensure that changes 
don't break one or more of the less activly maintained ports (sun4c 
Sparc32 has been a prime example of this).

Once broaken, it may not be practical to back out the problematic changes 
because they fix some important feature on several other platforms, so 
someone has to work out how to fix the issue and this can take a long 
time. While the fix is being worked on, development does not cease so once 
the fix has been worked out, a job lot of additional work may be needed 
before you end up with a working kernel. Bug fixers are forever playing 
cachup with other developers :).

Looking at the error log, your kernel build looks like it falls into this 
category. Recent changes to the DMA and Sparc/PowerPC prom code have made 
it posible to make drivers much more platform independent (less code to 
maintain and more testing so fiewer bugs). One side effect of this has 
been that the Sparc32 ports (and probably some others) were broaken for a 
while due to some configuration changes not making it through first time 
arround. For me, this had a knock on effect of making it more difficult to 
isolate the cause of a sun4c specific run-time failure (now fixed).

If you have the time, doing regular testing of the latest kernel 
available, on the platforms that you have hardware for, is the best way of 
ensuring that build/run-time issues are found quickly.

Once found and reported, it may be quicker for you to investigate/fix the 
problem and send in a patch, than to wait for someone else to have a go 
:).

Regards
 	Mark Fortescue.
