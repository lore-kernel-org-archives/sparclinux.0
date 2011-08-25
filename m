From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Thu, 25 Aug 2011 17:48:55 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110825174855.GB12155@alumni-linux.ccs.neu.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 25, 2011 at 11:58:22AM +0200, Josip Rodin wrote:
> 
> It looks as if something is generally screwing with the PCI detection logic
> from the get-go.
> 
> Do you happen to have a working kernel to fall back to, and then do a
> git bisect?

Yes I agree that there's something screwy in the detection logic.  I get
a "console [tty0] enabled, bootconsole disabled" when I don't use the
keep_bootcon kernel parameter, even though I have the
input-device=keyboard and output-device=screen openprom variables set.
So add bootconsole detection to the list of things that are screwy.

The most recent working kernel I have is 2.6.20 from the gentoo 2007.0
livecd.  I'm pretty sure I tried a 2.6.26 boot CD that failed, so I
assume that the problems begin sometime between those versions.

I'm happy to try different kernels from 2.6.20 onwards until I hit the
bug, thought it will take me some time to work through them.  Also
unfortunately the keep_bootcon patch
(http://patchwork.ozlabs.org/patch/78102/) doesn't apply cleanly to
2.6.20, which I would need to see the kernel panics.  I'll get started
and let you know when I track down where the problems begin.

