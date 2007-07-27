From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Fri, 27 Jul 2007 08:03:19 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070727080319.GA5924@sunflower.office.asoft.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jul 25, 2007 at 11:35:50PM -0700, David Miller wrote:
> 
> Anyways, my test program passes with the patch below, please
> give it a spin with your X problems...  it's against 2.6.23-rc1
> but should apply with only minor line offsets to 2.6.22
> 
> Thanks.
> 
> commit cff2c41772272f70524486f99991d0102dee0640
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Wed Jul 25 23:30:16 2007 -0700
> 
>     [SPARC64]: Fix sun4u PCI config space accesses on sun4u.
>

Yes, X finally works with this patch applied to kernel-2.6.22.1
Though it's not the clean result, because in the meantime I've upgraded to
xorg-server-1.3.0.0 (using debian's one-line patch), but anyway, 
xorg-server-1.3.0.0 didn't work for me with plain 2.6.22.1 either.
I'll try to downgrade back to my original xorg-server-1.1.1 and test it
too.

--
Best regards,
Dmitry 'MAD' Artamonow


