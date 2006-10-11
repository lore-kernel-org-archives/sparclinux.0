From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 11 Oct 2006 16:14:05 +0000
Subject: Re: [PATCH 2/4] fix sparc32 modpost warnings
Message-Id: <20061011161405.GB15959@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154503.GC30909@palantir8>
In-Reply-To: <20061010154503.GC30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 10, 2006 at 02:25:21PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Tue, 10 Oct 2006 16:45:03 +0100
> 
> > Fix these 2.6.19-rc1 build warnings from modpost:
> > 
> > WARNING: vmlinux - Section mismatch: reference to .init.data:boot_flags from .text between 'obp_system_intr' (at offset 0x12dd0) and 'show_cpuinfo'
>  ...
> > Index: linux/arch/sparc/kernel/setup.c
> > =================================> > --- linux.orig/arch/sparc/kernel/setup.c	2006-10-06 01:08:29.000000000 +0100
> > +++ linux/arch/sparc/kernel/setup.c	2006-10-07 02:32:20.000000000 +0100
> > @@ -122,7 +122,7 @@
> >  	.index =	-1,
> >  };
> >  
> > -int obp_system_intr(void)
> > +int __init obp_system_intr(void)
> >  {
> >  	if (boot_flags & BOOTME_DEBUG) {
> >  		printk("OBP: system interrupted\n");
> 
> This function isn't even referenced anywhere in the tree.
> We should just remove it, if anything.
> 
> I'll kill it from both sparc64 and sparc32, thanks.

Even better. Great!
Looking at this again it seems to me BOOTME_SINGLE and the '-s' flag is
not used/working either. Should I make a patch to remove that?

-- 
Martin
