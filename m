From: "C.Newport" <crn@netunix.com>
Date: Wed, 31 Mar 2004 09:09:43 +0000
Subject: Re: [PATCH 2.6] Various sparc32 cleanups
Message-Id: <200403311009.43251.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1080710480.27295.41.camel@zorak>
In-Reply-To: <1080710480.27295.41.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 March 2004 6:21 am, Tom 'spot' Callaway wrote:
> So, as part of an exercise in futility, I built 2.6 with CONFIG_SUN4=y.
> Not that there appears to be any working method to boot this kernel
> (yes, I do have a working sun4), but the cleanups needed were minor (and
> at least partially relevant to more modern sparc32 machines).
>
> Patch is attached. I have no idea if it works, but the bw2 fix is
> obviously correct.

Hmm - at last someone else who has a sun4.
I have not tried this for ages but a few pointers from memory.
The max size of the boot image is rather small so you need to
rip out all non-essentials. I am not sure what the PROM limits
are, but it might not be possible to make 2.6 small enough without
making an intermediate loader. SILO did not work.
Did you remember to use elftoaout with -b to remove the a.out
header bytes, it will not even start without this.

