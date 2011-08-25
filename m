From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Aug 2011 18:28:36 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110825182836.GA8882@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 25, 2011 at 01:48:55PM -0400, Jim Faulkner wrote:
> The most recent working kernel I have is 2.6.20 from the gentoo 2007.0
> livecd.  I'm pretty sure I tried a 2.6.26 boot CD that failed, so I
> assume that the problems begin sometime between those versions.
> 
> I'm happy to try different kernels from 2.6.20 onwards until I hit the
> bug, thought it will take me some time to work through them.  Also
> unfortunately the keep_bootcon patch
> (http://patchwork.ozlabs.org/patch/78102/) doesn't apply cleanly to
> 2.6.20, which I would need to see the kernel panics.  I'll get started
> and let you know when I track down where the problems begin.

IIRC older versions allowed us to specify "-p" as a parameter that had the
same effect.

If that doesn't work, you can also get the same by messing with the CON_BOOT
bit in a different place... [googling...] here we go, try the patch at the
bottom of http://patchwork.ozlabs.org/patch/14614/

Also the same bug report happens to have another possibly useful hint - the
'initcall_debug=1 ignore_loglevel' options.

-- 
     2. That which causes joy or happiness.
