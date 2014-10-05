From: Bob Picco <bpicco@meloft.net>
Date: Sun, 05 Oct 2014 13:58:22 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141005135822.GG22365@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Sat Oct 04 2014, 04:00:06PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Sat, 04 Oct 2014 15:12:37 -0400 (EDT)
> 
> > From: Bob Picco <bpicco@meloft.net>
> > Date: Thu, 2 Oct 2014 10:24:35 -0400
> > 
> >> At this commit:
> >> 59a35b1 sparc64: Use kernel page tables for vmemmap.
> > 
> > I think I figured out what the bug is.
> > 
> > It has to do with how KERN_PGTABLE_WALK masks in the sub-pagesize
> > bits for huge pages.
> > 
> > That assembler works fine for PAGE_OFFSET mappings where the
> > sub-pagesize bits always have a direct correspondance to the
> > physical bits.  But for something like vmemmap that doesn't
> > work.
> > 
> > I'll verify this and work on a fix.
> 
> Ok, this should do it, looking forward to see your test results:
This incremental patch has been on T5-8 since Saturday evening. There have
been NO issues related to our work for MM-IRQ.

I will use your version 3 and sparc.git for T5-8, local T5-2 and M7-4. Some
will occur today. The remainder early this week.
