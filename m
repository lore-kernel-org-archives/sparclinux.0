From: Bob Picco <bpicco@meloft.net>
Date: Wed, 17 Sep 2014 12:24:23 +0000
Subject: Re: [PATCH V2] sparc64: sun4v TLB error power off events
Message-Id: <20140917122423.GK17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 16 2014, 08:35:15PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Tue, 16 Sep 2014 20:16:51 -0400 (EDT)
> 
> > Anyways, we have to figure out why 0x8 is set in the PTE that we try
> > to load into ITLB.  I haven't found any smoking guns yet.
> 
> Looking more closely, the PTE 0x2900000dcc800eeb doesn't even have
> the valid bit set.
Yes.
> 
> Non-valid PTEs should not even get into the TSB, and non-valid PTEs
> found via page table lookup should vector us to the full fault path.
> 
> There used to be a bug where we'd put non-valid TTEs into the TSB
> but that was fixed by commit:
> 
> commit 18f38132528c3e603c66ea464727b29e9bbcb91b
> Author: David S. Miller <davem@davemloft.net>
> Date:   Mon Aug 4 16:34:01 2014 -0700
> 
>     sparc64: Do not insert non-valid PTEs into the TSB hash table.
> 
> Do you know if the kernels that triggered those ITLB BADRA errors had
> that fix or not?
I doubt it. I just checked my log for T4-2 and none of the kernels appears
close to this:
[bpicco@zareason linus.git]$ git describe --contains 18f38132528c3e603c66ea464727b29e9bbcb91b
v3.17-rc1~105^2~1^2~6
when the issue was revealed.
