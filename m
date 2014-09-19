From: Bob Picco <bpicco@meloft.net>
Date: Fri, 19 Sep 2014 19:57:31 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140919195731.GV17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Fri Sep 19 2014, 03:28:46PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Thu, 18 Sep 2014 19:16:37 -0400 (EDT)
> 
> > I'm half-way done with the "use kernel page tables for everything"
> > patch, and will post once I have something that at least work for
> > me.
> 
> Bob, I ran into a major roadblock which is going to delay this work
> a little bit.
Okay.
> 
> In fact it pointed out a bug we introduced when increasing max phys
> bits to 47.  We broke DEBUG_PAGEALLOC completely.  The issue is that
> the page table layout only supports up to 43-bits.
Oh bugger yes. I recall testing this when first introducting four level
page table layout in late 2012 and early 2013. It just isn't an everyday
thought but VERY nice to have.
> 
> I'll brain storm about this over the weekend.
Me too.
