From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 27 Oct 2004 02:27:27 +0000
Subject: Re: PATCH for Sun4c clones with an 82077 FDC
Message-Id: <20041027022727.GQ15367@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10410270242340.26459-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410270242340.26459-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: davem@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:03:34AM +0100, Mark Fortescue wrote:
> I have been having trouble working out why my sun4c sparc clone could not
> find the floppy drive. I was being blind as floppy.h assumes that all
> sun4c machines only have an 82072 FDC. This asumption is not valid for
> some clones (OPUS Personal Mainframe 5000 sun4c sparc1 clone for one).
> The patch below checks to see if it is an 82072 using a simple test before
> assuming that we have an 82072. It works on my clone but it needs to be
> checked on a sun4c system with an 82072 FDC.
> Can someone with a sun4c system that has an 82072 check it to see if it
> works for them. The extra two printk messages are more for diagnostics
> when the patch is being tested (via prom console). If it does not break
> 82072 sun4c systems then the two diagnostic messages can be removed. If it
> does break the 82072 sun4c systems, then a more complicated test is
> needed that does not.

Okay, can this be done without media? I have the sun4c's, but not floppy
media. I suppose I could obtain some for the occasion.


-- wli
