From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 10 Nov 2004 04:55:32 +0000
Subject: Re: Fix for HyperSPARC DMA errors
Message-Id: <20041109205532.267266fe.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419188A0.3010307@mc.net>
In-Reply-To: <419188A0.3010307@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 9 Nov 2004 19:30:10 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> I'll take this for a spin on one of my SS20's. I've had no success
> debugging this myself, and am astounded at how small your solution is.

In particular, not setting srmmu_modtype is a pretty clear
error :-)
