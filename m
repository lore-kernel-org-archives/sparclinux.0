From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 29 Jul 2004 00:11:41 +0000
Subject: Re: SMP support in 2.6.x kernel for sparc32
Message-Id: <20040729001141.GJ2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <001301c474db$af707860$3c01a8c0@cascade>
In-Reply-To: <001301c474db$af707860$3c01a8c0@cascade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 28 Jul 2004 16:53:29 -0700 William Lee Irwin III wrote:
> | I just rediffed the smp patch by brute force vs. 2.6.8-rc2. I'll spin
> | it up on 3x hypersparc if it turns out the box is actually functional
> | and see where it explodes sometime in the next 72 hours.

On Thu, Jul 29, 2004 at 01:05:27AM +0100, Ciaran McCreesh wrote:
> Well, hypersparc has a whole extra set of problems. Unless you use an
> embedded root it's got a ~97% chance of not running init. Only way to
> run a proper userspace on hypersparcs with 2.6.x is to boot into
> busybox, nfsmount a system image and then repeatedly try to run things
> until you get lucky with DMA...

Yes, I will need to fix the hypersparc DMA issue as well. Nothing wrong
with that, it needs fixing anyway.

Actually my system is diskless anyway, so I will in all probability get
whatever result you're expecting from nfsroot by coincidence anyway.

If you've got fixes already feel free to send them my way.
Thanks.


-- wli
