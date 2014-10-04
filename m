From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 19:12:37 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141004.151237.1017479021991918854.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 2 Oct 2014 10:24:35 -0400

> At this commit:
> 59a35b1 sparc64: Use kernel page tables for vmemmap.

I think I figured out what the bug is.

It has to do with how KERN_PGTABLE_WALK masks in the sub-pagesize
bits for huge pages.

That assembler works fine for PAGE_OFFSET mappings where the
sub-pagesize bits always have a direct correspondance to the
physical bits.  But for something like vmemmap that doesn't
work.

I'll verify this and work on a fix.
