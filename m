From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 10 Nov 2004 05:23:29 +0000
Subject: Re: Fix for HyperSPARC DMA errors
Message-Id: <20041110052329.GB3217@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <419188A0.3010307@mc.net>
In-Reply-To: <419188A0.3010307@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 9 Nov 2004 19:30:10 -0800 William Lee Irwin III wrote:
>> I'll take this for a spin on one of my SS20's. I've had no success
>> debugging this myself, and am astounded at how small your solution is.

On Tue, Nov 09, 2004 at 08:55:32PM -0800, David S. Miller wrote:
> In particular, not setting srmmu_modtype is a pretty clear
> error :-)

You're right, this wants to be merged soon.

Bob, how do you feel about your arch/sparc/mm/iommu.c flush_cache_all()
hack? Would you prefer to have that in mainline for the time being, or
would you rather wait until you devise a better solution?


-- wli
