From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 02 Nov 2004 22:57:37 +0000
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Message-Id: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <200411030540.06262.adaplas@hotpop.com>
In-Reply-To: <200411030540.06262.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com


Will this work for a kernel Panic ?

Mark

On Wed, 3 Nov 2004, Antonino A. Daplas wrote:

> On Wednesday 03 November 2004 02:03, Mark Fortescue wrote:
> > Hi all,
> >
> > I have identified what is going on. My CG3 console uses the same font and
> > exactly overlaps prom console. [I have re-inserted the console margin code
> > for my CG3 driver]. The timing is such that the prom overwrites the
> > console text (using colour 255) a fraction later than the fbcon code.
> >
> > The two problems to be solved are (apart from seting the red,green and
> > blue structures up for the cg series fb cards):
> >
> > 1) The prom write (from -p) needs to be disabled as soon as an alternative
> > console becomes active (either prom console, fbcon console or serial
> > console). This has probably been the major cause of hassel.
> >
> > 2) The restore pallet function (see cgsix.c in the 2.2.x or 2.4.x kernels)
> > needs to be re-introduced in some form and called when exiting fbcon so
> > that the prom does not end up as black on black. My prom uses fg%5,
> 
> You can implement a cg3fb_open() and cg3fb_release() hooks and set up a
> use_count field. You increment the count on every open, decrement on every
> release. Then restore whatever on the last release. Optionally, you can even
> do hardware inits on the first open.
> 
> Tony 
> 
> 

