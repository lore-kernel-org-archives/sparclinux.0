From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 10 Nov 2004 05:30:26 +0000
Subject: Re: Fix for HyperSPARC DMA errors
Message-Id: <20041109213026.134c8e63.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419188A0.3010307@mc.net>
In-Reply-To: <419188A0.3010307@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 9 Nov 2004 21:23:29 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> Bob, how do you feel about your arch/sparc/mm/iommu.c flush_cache_all()
> hack? Would you prefer to have that in mainline for the time being, or
> would you rather wait until you devise a better solution?

I think even this part of Bob's patch should just go in.
At worst it will slow things down for people, and it will
fix real bugs for people.
