From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 27 Oct 2004 12:06:56 +0000
Subject: Re: PATCH for Sun4c clones with an 82077 FDC
Message-Id: <Pine.LNX.4.10.10410271303550.27630-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <20041027022727.GQ15367@holomorphy.com>
References: <Pine.LNX.4.10.10410270242340.26459-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410270242340.26459-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davem@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi William,

Yes it can. All it is trying to do is determin the type of FDC on boot.
Build up a new kernel (with prom console) and start it up with "-p
console=prom" or similar command line options so you can see the
diagnostics as the kernel starts up.

Regards
	Mark Fortescue.

On Tue, 26 Oct 2004, William Lee Irwin III wrote:

> On Wed, Oct 27, 2004 at 03:03:34AM +0100, Mark Fortescue wrote:
> > I have been having trouble working out why my sun4c sparc clone could not
> > find the floppy drive. I was being blind as floppy.h assumes that all
> > sun4c machines only have an 82072 FDC. This asumption is not valid for
> > some clones (OPUS Personal Mainframe 5000 sun4c sparc1 clone for one).
> > The patch below checks to see if it is an 82072 using a simple test before
> > assuming that we have an 82072. It works on my clone but it needs to be
> > checked on a sun4c system with an 82072 FDC.
> > Can someone with a sun4c system that has an 82072 check it to see if it
> > works for them. The extra two printk messages are more for diagnostics
> > when the patch is being tested (via prom console). If it does not break
> > 82072 sun4c systems then the two diagnostic messages can be removed. If it
> > does break the 82072 sun4c systems, then a more complicated test is
> > needed that does not.
> 
> Okay, can this be done without media? I have the sun4c's, but not floppy
> media. I suppose I could obtain some for the occasion.
> 
> 
> -- wli
> 

