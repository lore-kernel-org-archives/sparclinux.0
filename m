From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 21 Dec 2004 06:09:26 +0000
Subject: Re: [2/3] sun4d updates (guys, please send me real descriptions!)
Message-Id: <20041220220926.5d4a0295.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221042836.GZ771@holomorphy.com>
In-Reply-To: <20041221042836.GZ771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Dec 2004 20:39:46 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> Dave, I got the following hunk from Chris Newport and Thomas Bogendoerfer.
> I'm not sure of your opinion regarding sun4d impact on generic sbus
> driver code. I can drop this hunk (vs. 2.6.10-rc3) if it's not acceptable.

It looks like it's probably correct.  Each system board is where
the various SBUS's live, and therefore the SBUS relative ranges
need to be adjusted to be relative to the entire system's physical
addressing range.  It appears the iounit ranges do that for the
sun4d SBUS nodes.
