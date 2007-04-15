From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sun, 15 Apr 2007 00:54:10 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <1176598450.3970.265.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(...forgot to CC sparclinux)

On Sat, 2007-04-14 at 17:12 -0700, David Miller wrote:

> Actually, scratch that.
> 
> I think I know what the problem is, you need this fix below in your
> tree too.  This is upstream as of the beginning of last week so you
> perhaps don't have it, although I've posted it explicitly to you on
> several occaisions.
> 
> This bug causes sense data to not get copied at all into the scsi
> sense buffer, which makes all manner of things go wrong as you
> can imagine :)
> 
> I'm guessing that normally on your system this disk needs to be spun
> up during the initial scsi bus scan?  I guess this also means you are
> net-booting these kernels else the disk would be spun-up already by
> the firmware.
> 
> Either way, give this patch below a spin and let me know how it
> goes.

This patch is already in my tree. The kernel base is
patch-2.6.21-rc6-git5.

I'm not netbooting these kernels either. Straight boot from firmware,
system is serial connected through a screen (which is where the logs are
coming from).

Additional thoughts? :)

~spot

