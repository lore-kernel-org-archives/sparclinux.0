From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 01 Aug 2004 01:18:42 +0000
Subject: Re: Ross HyperSPARC DMA
Message-Id: <20040801011842.GL2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040731212044.GF2334@holomorphy.com>
In-Reply-To: <20040731212044.GF2334@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jul 31, 2004 at 02:20:44PM -0700, William Lee Irwin III wrote:
> Could a volunteer please identify which 2.3.x kernel introduced the
> HyperSPARC DMA failure? Binary search to narrow it down to a point
> release is all I'm looking for right now.

It looks like Rob Radez is working this on my hardware remotely atm.

The regression I'm referring to here is for SMP only. There was a
second regression, somewhere between then and 2.6.x-CURRENT, which
breaks DMA on HyperSPARC for UP also, i.e. all remaining HyperSPARCs.
If other volunteers could find what release broke that, I'd be much
obliged.

I don't have enough hardware to supply a second person so plan
accordingly.


-- wli
