From: David Miller <davem@davemloft.net>
Date: Sun, 03 Jun 2007 18:38:52 +0000
Subject: Re: Alignment question, sparc-centric
Message-Id: <20070603.113852.48823841.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 3 Jun 2007 12:26:45 +0200 (MEST)

> 
> On Jun 3 2007 12:14, Bernhard R. Link wrote:
> >
> >* David Miller <davem@davemloft.net> [070602 22:09]:
> >> Types must be aligned on their natural size, and GCC can assume
> >> this everywhere you reference such types unless you use the
> >> "packed" GCC attribute.
> >
> >And even with packed, the struct itself must be naturally aligned
> >(unless itself is in a packed struct, if course).
> 
> It is not a struct actually. It is a bytestream that is reinterpreted
> as an integer, that is, for example (it does not really need to be
> skb_network_header),
> 
> unsigned char *p = skb_network_header(skb);
> uint32_t value   = *(uint32_t *)(p[9]);
> 
> I suppose this won't work, so one would have to...
> 
> uint32_t value = (p[0] << 24) | (p[1] << 16) | (p[2] << 8) | p[3];

We have a way to handle this in the kernel, it's called
get_unaligned() and it only emits special unaligned handling on the
platforms that require it:

	value = get_unaligned((u32 *)(p + 9));

Use it :-)
