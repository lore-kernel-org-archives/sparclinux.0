From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 10 Nov 2004 03:30:10 +0000
Subject: Re: Fix for HyperSPARC DMA errors
Message-Id: <20041110033010.GA3217@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <419188A0.3010307@mc.net>
In-Reply-To: <419188A0.3010307@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 09, 2004 at 09:18:56PM -0600, Bob Breuer wrote:
> I found a solution for the HyperSPARC DMA problems in 2.6.  This allows
> my SS20 with HyperSPARCs to boot to single user.  It's not efficient,
> but I hope it points out whats needed for a proper fix.  Seems that the
> iotlb entries need to flushed to ram or uncached since the iommu changes
> between 2.5.60 and 2.5.70.
> The second part seems to be needed to allow consistent sbus dma mappings
> to be cached on HyperSPARC.  I have also tested this change on 2.4.27
> with no noticeable difference.  Can anyone prove if it helps or hurts?

I'll take this for a spin on one of my SS20's. I've had no success
debugging this myself, and am astounded at how small your solution is.


-- wli
