From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 10:16:06 +0000
Subject: Re: [PATCH] sparc64: valid physical address bitmap
Message-Id: <20140918101606.GQ17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Wed Sep 17 2014, 05:00:48PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 16 Sep 2014 12:52:17 -0400
> 
> > From: bob picco <bpicco@meloft.net>
> > 
> > We need to constrain the size of sparc64_valid_addr_bitmap. Historically
> > it has been sized according to maximum physical address and 4Mb DIMM size.
> > This was sufficient with older sparc64 before larger physical address bits.
> > 
> > This patch limits the bitmap to 64Kb by a smaller value for a physical
> > address bits which cover the vast majority of sparc64.
> > 
> > The last_valid_pfn is used to limit the physical address limit within
> > the ktlb miss for identity address checking and increase the megabyte shift
> > granularity of the check for a valid pfn.
> > 
> > An LDOM guest might have an issue with this depending on how the PA to
> > RA ranges were assigned by the control domain. Though this issue already
> > seems to exist for a granularity less than 4Mb which is the current
> > bitmap shift and test.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> 
> Let's stop fighting this thing.
Oh do I understand :)
> 
> Instead, let's just kill the bitmap off completely and scan the 'reg'
> property of the 'memory' OF node.  It's well formed and very small,
> and now it doesn't matter what granularity works or not for LDOM
> guests as well.
I like the idea.

There might be one issue: 
The machine has more reg property entries than this kernel can support (32). 
Program terminated 
. It is a T4-4 LDOM guest configured with an absurd number of PA <-> RA
mappings. I haven't examined the issue further than this.

I've invested infinite zero time reviewing your code.
> 
> Bonus is that the BSS section shrinks by 4MB after this change.
> 
> This is a really delicate change, the more testing the better.  I've
> only done basic sanity tests on T4-2 so far.
