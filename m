From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 06:36:45 +0000
Subject: Re: [2/3] sun4d updates (guys, please send me real descriptions!)
Message-Id: <20041221063645.GE771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221042836.GZ771@holomorphy.com>
In-Reply-To: <20041221042836.GZ771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Dec 2004 20:39:46 -0800 William Lee Irwin III wrote:
>> Dave, I got the following hunk from Chris Newport and Thomas Bogendoerfer.
>> I'm not sure of your opinion regarding sun4d impact on generic sbus
>> driver code. I can drop this hunk (vs. 2.6.10-rc3) if it's not acceptable.

On Mon, Dec 20, 2004 at 10:09:26PM -0800, David S. Miller wrote:
> It looks like it's probably correct.  Each system board is where
> the various SBUS's live, and therefore the SBUS relative ranges
> need to be adjusted to be relative to the entire system's physical
> addressing range.  It appears the iounit ranges do that for the
> sun4d SBUS nodes.

Sounds like good news to me. I'll send it on, then. In related news, I
should be able to do more direct sun4d hacking soon. The only obstacles
left are physical logistics wrt. power and the like (thanks Keith!).


-- wli
