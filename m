From: David Miller <davem@davemloft.net>
Date: Fri, 07 Jul 2006 07:05:24 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060707.000524.112600047.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060937.k669bZT3017256@harpo.it.uu.se>
In-Reply-To: <200607060937.k669bZT3017256@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 6 Jul 2006 11:37:35 +0200 (MEST)

> On Wed, 05 Jul 2006 20:40:36 -0700 (PDT), David Miller wrote:
> >> I.e., X did a simple PROT_READ|PROT_WRITE MAP_SHARED mmap() of
> >> something PCI-related, presumably the ATI card. The protection
> >> bits passed into io_remap_pfn_range() are 0x80...0788, while
> >> pg_iobits are 0x80...0f8a. Current kernels obey the prot bits,
> >> which, if I read things correctly, means that _PAGE_W_4U and
> >> _PAGE_MODIFIED_4U don't get set any more.
> >> 
> >> I guess something else in the kernel should have set those
> >> bits before they got to io_remap_pfn_range()?
> >
> >The problem is with X, it should not be doing a MAP_SHARED
> >mmap() of the framebuffer device.  It should be using
> >MAP_PRIVATE instead.
> >
> >The kernel is trying to provide copy-on-write semantics for
> >the mapping, which doesn't make any sense for device registers.
> >That's why the kernel isn't setting the writable or modified
> >bits in the protection bitmask.
> 
> Now I'm confused. That COW behaviour would be consistent with
> MAP_PRIVATE, not MAP_SHARED which is what X did use.

Yes, I'm totally wrong here, MAP_SHARED is correct.

I'll have to figure out how the writeable bits get lost
in the call chain.

Thanks.
