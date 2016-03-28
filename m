From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 28 Mar 2016 15:37:43 +0000
Subject: Re: [PATCH 10/31] Add sparc-specific parity functions
Message-Id: <20160328153743.GA13061@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <56F780FE.7000600@gmail.com>
 <20160327.224308.220596078048860811.davem@davemloft.net>
 <56F8C4A3.1070808@gmail.com>
 <20160328.112915.1286498398436148099.davem@davemloft.net>
In-Reply-To: <20160328.112915.1286498398436148099.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: zhaoxiu.zeng@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Mar 28, 2016 at 11:29:15AM -0400, David Miller wrote:
> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
> Date: Mon, 28 Mar 2016 13:44:03 +0800
> 
> > 在 2016年03月28日 10:43, David Miller 写道:
> >> From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
> >> Date: Sun, 27 Mar 2016 14:43:10 +0800
> >>
> >>> +
> >>> +/*
> >>> + * parityN: returns the parity of a N-bit word,
> >>> + * i.e. the number of 1-bits in x modulo 2.
> >>> + */
> >>> +
> >>> +#define __arch_parity4(w)	(__arch_hweight8((w) & 0xf) & 1)
> >>> +#define __arch_parity8(w)	(__arch_hweight8(w) & 1)
> >>> +#define __arch_parity16(w)	(__arch_hweight16(w) & 1)
> >>> +#define __arch_parity32(w)	(__arch_hweight32(w) & 1)
> >>> +#define __arch_parity64(w)	((unsigned int)__arch_hweight64(w) & 1)
> >> This looks like asm-generic/ material to me.
> > 
> > This is generic for the architectures which have popcount instruction,
> > but more higher costs than asm-generic/ for others.
> 
> Which is why said stanza's in the asm-generic header should be triggered
> by a CPP define or similar.
For sparc we would need to do a run-time patch as far as I see.

If popc is availble then use of hweight* should be fine.
But without popc then I think the generic implementation that
uses the stanford algorithm would be most efficient,
rather than the base this on the generic hweight functions.

	Sam
