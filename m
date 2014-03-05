From: Bob Picco <bpicco@meloft.net>
Date: Wed, 05 Mar 2014 20:18:12 +0000
Subject: Re: [PATCH] sparc64 - strict devmem
Message-Id: <20140305201812.GA29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1393866035-7939-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1393866035-7939-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Tue Mar 04 2014, 03:46:26PM EST]
> From: Bob Picco <bpicco@meloft.net>
> Date: Mon,  3 Mar 2014 12:00:35 -0500
> 
> > From: bob picco <bpicco@meloft.net>
> > 
> > This patch adds support to enable STRICT_DEVMEM for sparc64. By selecting the
> > new config option you enable this feature.
> > 
> > CC: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> 
> Ok, I looked more deeply into this and I'm going to rescind my request
> to use kern_addr_valid().
> 
> This devmem_is_allowed() seems to also want to allow non-RAM MMIO
> accesses too.
> 
> So using the iomem resource is probably the way to go.
> 
> Two things:
> 
> 1) We have to make sure caching will be disabled and the side-effect
>    bit will be set in accesses to non-RAM pages.
> 
> 2) Our implementation of devmem_is_allowed() should be aligned as
>    much as possible with other implementations.  Perhaps powerpc
>    is the best example to use.
Alright, hold off on strict_devmem. I realize after looking at powerpc
that 1 1/2 years ago my exhaustion consumed me. I plugged up bus error
with strict_devmem by inverting the purpose of strict_devmem. In other words,
I allow memory access but don't allow MMIO and HOLES. Very sorry about this!

Let me plug up the bus error differently.

Hm, I'm not certain to be all that thrilled with strict_devmem any longer.
Though I'm certain some security person would be.

This is what happens when your brain is fried which it was 1 1/2 years ago.

thanx,

bob
> 
> Thanks.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
