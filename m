From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 12:52:06 +0000
Subject: Re: [PATCH] sparc64: vmemmap boot sizing
Message-Id: <20140918125206.GR17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Thu Sep 18 2014, 12:45:38AM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 16 Sep 2014 12:53:24 -0400
> 
> > From: bob picco <bpicco@meloft.net>
> > 
> > This patch attempts to accomodate the coarse grain memory controller unit
> > (MCU) in Niagara5 and later generations. This is achieved by having a root
> > array which is array of pointers to arrays of TTE-s for vmemmap. The ktlb
> > paths are patched when using the root array.
> > 
> > Older sparc64 should have the net effect of being treated similar to before
> > the introduction of Niagara5 and Athena which caused an increase in memory
> > footprint of static sparc64 related memory management items.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> 
> We already have a rather nice data structure for storing sparse mappings
> of the virtual address space, in the form of the Linux page tables, so
> let's just use that. :-)
> 
> This also shrinks the kernel BSS by 2MB.
This looks good too!  I wasn't about to make the decision for sun4u.

Let me first test all three on my T5-2 local to me. Well, review some too.

Then I'll hit the M7-4 again.

Oh please remind me to mention percpu chunk allocator. Quickly we need
need to enlarge VMALLOC space significantly but this is old data.

thanx!
