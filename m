From: Bob Picco <bpicco@meloft.net>
Date: Wed, 17 Sep 2014 19:22:37 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140917192237.GN17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Wed Sep 17 2014, 01:16:22PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 16 Sep 2014 12:50:39 -0400
> 
> > From: bob picco <bpicco@meloft.net>
> > 
> > For physical address larger than 47 bits the computed physical address
> > was insufficient within KERN_TSB_LOOKUP_TL1. This resulted in a vmlinux
> > loaded above 47 bits of physical address unable to boot in spectacular
> > ways.
> > 
> > For now we've expanded the physical address range to 52 bits at the cost of
> > two instructions. Older sparc64 incur two nop-s.
> > 
> > The two new instructions from this patch and the former KTSB_PHYS_SHIFT can
> > potentially be eliminated using memblock aligning large and constraining
> > the physical limit. Essentially use the "sethi" for a physical manipulated
> > address and replacing the "or" at patch time with a "sllx". This would leave
> > the tsb within head_64.S unused and possibly not a good solution for Cheetah+.
> > We'll comtemplate this more in another round.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> 
> Bob, I think we can do this with a 4 instruction sequence, basically
> "sethi, sethi, sllx, or".  The two sethi's give us 22 bits each, and
> we again take advantage of the 32K+ alignment of both kernel TSBs.
> 
> Can you give this patch below a quick test on your machine that hits
> this issue?
Yes, please give me until later tomorrow. One, I haven't wrapped my
head around this code in a bit. The other, the machine is possibly
closer to you than me and can be temperamental.
> 
> Thanks.
you're welcome,

bob
