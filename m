From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 17 Apr 2012 17:23:01 +0000
Subject: Re: [PATCH] net: filter: Just In Time compiler for sparc
Message-Id: <1334683381.2472.44.camel@edumazet-glaptop>
List-Id: <sparclinux.vger.kernel.org>
References: <20120416.225823.1395194623649559124.davem@davemloft.net>
	 <4F8DA21E.9020809@computer.org>
In-Reply-To: <4F8DA21E.9020809@computer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Ceuleers <jan.ceuleers@computer.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, 2012-04-17 at 19:02 +0200, Jan Ceuleers wrote:
> David Miller wrote:
> >
> > Signed-off-by: David S. Miller<davem@davemloft.net>
> > ---
> >
> > I think I'll commit this to net-next so it's easier to track
> > any BPF changes we make there.
> 
> I hate to nitpick; see below.
> 
> > +	bl	bpf_slow_path_word_neg
> > +	 nop
> > +	.globl	bpf_jit_load_word_positive_offset
> > +bpf_jit_load_word_positive_offset:
> > +	sub	r_HEADLEN, r_OFF, r_TMP
> > +	cmp	r_TMP, 3
> > +	ble	bpf_slow_path_word
> > +	 add	r_SKB_DATA, r_OFF, r_TMP
> > +	andcc	r_TMP, 3, %g0
> > +	bne	load_word_unaligned
> > +	 nop
> > +	retl
> > +	 ld	[r_SKB_DATA + r_OFF], r_A
> 
> There is inconsistent spacing in multiple places; a few examples shown 
> above.

Thats ok, after a branch : Delay slot




