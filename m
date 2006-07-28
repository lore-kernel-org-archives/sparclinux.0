From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jul 2006 01:13:56 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060727.181356.71087770.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607060937.k669bZT3017256@harpo.it.uu.se>
	<20060707.000524.112600047.davem@davemloft.net>
In-Reply-To: <20060707.000524.112600047.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 07 Jul 2006 00:05:24 -0700 (PDT)

> I'll have to figure out how the writeable bits get lost
> in the call chain.

Actually, I digged further, things seem correct.

Initially we only set the SW-writable bit, and this is the right thing
to do for a MAP_SHARED writable mapping.

If the process actually tries to write to the mapping, the page fault
path will set the two bits that actually enable writes, namely the
HW-writable bit and the SW-dirty bit.

This occurs when pte_mkdirty() is called on the PTE during the
execution of mm/memory.c:handle_pte_fault(), right here:

	if (write_access) {
		if (!pte_write(entry))
			return do_wp_page(mm, vma, address,
					pte, pmd, ptl, entry);
		entry = pte_mkdirty(entry);
	}

pte_write() will return true, since the SW-writable bit is set.  So we
don't should not invoke do_wp_page(), and we'll just set the dirty bit
on the existing PTE.

For some reason that isn't happening properly, or something keeps
clearing the HW-writable bit on us.  Another possibility is that
one of these operations sets the cacheable bits, or clears the
side-effect bit, either of which would cause corruption or other
problems when accessing the ATI card through such a mapping.

I wonder why.... I'll try to run some experiments on my system to try
and get to the bottom of this.
