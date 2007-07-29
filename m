From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 29 Jul 2007 15:45:35 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070729174535.9eb6d0aa.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 29 Jul 2007 00:21:06 +0100 (BST)
Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:

> Hi Krzysztof,
> 
> There have been lots of changes to the DMA system (git bisect is not 
> viable form my working 2.6.22 kernel as the dma changes kill the build for 
> over half the posible commits to check). It could be a side effect of 
> these changes.
> 

It is not DMA I suppose. It does not happen in any specific place. It is easy to trigger by loading 
and unloading the sunlance module, but it hangs linux in other places (init process, console login).

It happens only in SMP. If it happens in the sunlance module it happens in sparc_lance_probe_one()
(in probing function). I thought it is due to openprom accesses so I commented them out (and put 
hardcoded values there). No real change. It is always in the probe_one method before any DMA is
started.

Sometimes it drops me to the prom prompt. I am not very experienced so I was able only to find (ctrace) that
the prompt was called in the method spwin_bad_ustack_from_kernel() which got there from mna_handler
(misaligned access) through kernel_unaligned_trap(). I don't know which function triggered the 
unaligned access. The %o register values sent to the kernel_unaligned_trap() are outside addresses 
from System.map and outside addresses of loaded (or just loaded the sunlance) modules.

This is where I need help. How can I find where the misaligned access happened?

Regards,
Krzysztof
