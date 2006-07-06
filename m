From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jul 2006 03:40:36 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060705.204036.104053108.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 3 Jul 2006 13:17:44 +0200 (MEST)

> I.e., X did a simple PROT_READ|PROT_WRITE MAP_SHARED mmap() of
> something PCI-related, presumably the ATI card. The protection
> bits passed into io_remap_pfn_range() are 0x80...0788, while
> pg_iobits are 0x80...0f8a. Current kernels obey the prot bits,
> which, if I read things correctly, means that _PAGE_W_4U and
> _PAGE_MODIFIED_4U don't get set any more.
> 
> I guess something else in the kernel should have set those
> bits before they got to io_remap_pfn_range()?

The problem is with X, it should not be doing a MAP_SHARED
mmap() of the framebuffer device.  It should be using
MAP_PRIVATE instead.

The kernel is trying to provide copy-on-write semantics for
the mapping, which doesn't make any sense for device registers.
That's why the kernel isn't setting the writable or modified
bits in the protection bitmask.

Please fix the X server :)
