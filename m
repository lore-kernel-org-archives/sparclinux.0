From: David Miller <davem@davemloft.net>
Date: Thu, 18 Sep 2014 17:05:34 +0000
Subject: Re: [PATCH] sparc64: valid physical address bitmap
Message-Id: <20140918.130534.533150835721495140.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 06:16:06 -0400

> David Miller wrote:	[Wed Sep 17 2014, 05:00:48PM EDT]
>> Instead, let's just kill the bitmap off completely and scan the 'reg'
>> property of the 'memory' OF node.  It's well formed and very small,
>> and now it doesn't matter what granularity works or not for LDOM
>> guests as well.
> I like the idea.
> 
> There might be one issue: 
> The machine has more reg property entries than this kernel can support (32). 
> Program terminated 
> . It is a T4-4 LDOM guest configured with an absurd number of PA <-> RA
> mappings. I haven't examined the issue further than this.

Ok.  Given some of the other work I did last night, and after some more
consideration, I think I have a better idea of how to handle this.

Let's just use kernel page tables for everything.

We'll put huge PMDs into the kernel page tables for the linear mappings
and this will serve two purposes:

1) Physical address validation

2) Huge page size selection

And the kernel page tables deal naturally with sparseness.

We just have to set it up after we take over the trap table from OF.
(otherwise we can't actually access any early memory we allocate via
memblock or similar)  And we have the infrastructure to do that, with
instruction patching.

We simply accept all TLB misses to the linear area, strictly use only
4MB TTEs, before we setup the kernel page tables.

I'll see if I can throw something together today.
