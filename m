From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 18 Apr 2011 20:36:33 +0000
Subject: Re: Sparc station IPX (sparc32 - sun4c) does not boot Linux
Message-Id: <20110418203633.GA13513@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110418065540.GA21094@merkur.ravnborg.org>
In-Reply-To: <20110418065540.GA21094@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 18, 2011 at 04:57:43PM +0100, mark@mtfhpc.demon.co.uk wrote:
> Hi Sam,
> 
> Thee things that may help.
> 
> 1) Change head.S to remap 8M. Last time I did anything on
> sun4c, it only remapped 3M and minimum kernel size i
> ended up working with was > 3M.
This looked rather promising - but same result.

I only changed this:
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -716,7 +716,7 @@ sun4_normal_loop:
 sun4c_remap:
                mov     0, %g3                  ! source base
                set     KERNBASE, %g4           ! destination base
-               set     0x300000, %g5           ! upper bound 3MB
+               set     0x800000, %g5           ! upper bound 8MB
                mov     1, %l6
                sll     %l6, 18, %l6            ! sun4c mmu segmap size

I think we get stuck somewhere before this - or durign the very
early phases. I tried to read out call-chain with prom debugger.
But that failed.

My attempts to set proper breakpoints also failed - maybe I
mixed up some addresses.

I have left it for now as I need to get forward with other stuff.

> 2) Add in code to disable the Lance before setting up
> the device tree. If you don't do this then it may generate
> interrupts before you have a handler installed.
> DaveM had a patch for this somewhere (> 2 years ago).

Digged a little. Found a patch that dacem created in response
to a thread you were invloved in.

commit 76fcdb30ae1cb28e438e5ffd4db5f49ea3d96cd7
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Jul 30 18:23:39 2007 -0700

    [SUNLANCE]: Fix sparc32 crashes by using of_*() interfaces.

    This driver was still using the deprecated prom_*() interfaces to
    obtain values out of the OBP device tree, and this is causing
    some kinds of problems on sparc32 especially SMP boxes.

    Signed-off-by: David S. Miller <davem@davemloft.net>

So I think it is fixed in-tree. And I anyway does not get that far.

> 3) I had problems with my SparcStation clone. It has a CG3
> and the default driver set up results in a black on black
> screen. This is fine when using serial console but a pain
> if you forget to unplug the keyboard before booting.

Good to know.

Thanks for your reply!

	Sam
