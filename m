From: "C.Newport" <crn@netunix.com>
Date: Thu, 19 Aug 2004 23:46:45 +0000
Subject: Re: Sun4d SMP - retests - patch was not required
Message-Id: <200408200046.45635.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408192322.43126.crn@netunix.com>
In-Reply-To: <200408192322.43126.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 20 August 2004 12:09 am, William Lee Irwin III wrote:

> On Fri, Aug 20, 2004 at 12:04:52AM +0100, C.Newport wrote:
> > Just send me the tests and I will run them.
> > Comparisons with 2.2 will not help, there was no SMP capable version.
> > I will give 2.4.27 UP a good thrashing tomorrow - any instability there
> > might give us some more clues.
>
> These aren't tests per se, they're C code to print out extra
> information. This generally needs to be done by hand and with some
> insight into what you're looking at so as to find the relevant things
> to print. With no extant working SMP sun4d kernel there's nothing to
> really compare against, so I think we're going to have to do something
> else here anyway, though some similar information may be useful for it.

I am perfectly happy adding and removing bits of C code and testing the
result - what I lack is the kernel insights. This is a clumsy way to work but
probably the best we have at this stage unless Thomas has the time to
poke around in the interrupt stuff. (Or maybe someone else will volunteer).

BTW - the -p breakage also happens in 2.4.27 UP so it is probably
a red herring. We should get it fixed anyway before it causes more
confusion. I will try the same kernel on a Sun4m machine tomorrow
and see if it also happens there. I have a SS20 with 2 x SM81 as well
as SS5 and SS10. Is there any point in checking this on Sun4c - or
is this still too broken to worry about.


