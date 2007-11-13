From: David Miller <davem@davemloft.net>
Date: Tue, 13 Nov 2007 11:47:37 +0000
Subject: Re: Vmstat: Small revisions to refresh_cpu_vm_stats()
Message-Id: <20071113.034737.199780122.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0711091837390.18567@schroedinger.engr.sgi.com>
	<20071113033755.c2e64c09.akpm@linux-foundation.org>
In-Reply-To: <20071113033755.c2e64c09.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: clameter@sgi.com, linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 13 Nov 2007 03:37:55 -0800

> : undefined reference to `__xchg_called_with_bad_pointer'
> 
> This is sparc64's way of telling you that you can'd do xchg on an s8.
> 
> Dave, is that fixable?
> 
> I assume not, in which case we either go for some open-coded implementation
> for 8- and 16-bits or we should ban (at compile time) 8- and 16-bit xchg on
> all architectures.

Right, let's write some generic code for this because other platforms
are going to need this too.

Basically, do a normal "ll/sc" or "load/cas" sequence on a u32 with
some shifting and masking as needed.

	int shift = (((unsigned long) addr) % 4) * 8;
	unsigned long mask = 0xff << shift;
	unsigned long val = newval << shift;
	u32 *ptr = (u32 *) ((unsigned long)addr & ~0x3UL);

	while (1) {
		u32 orig, tmp = *ptr;

		orig = tmp;
		tmp &= ~mask;
		tmp |= val;
		cmpxchg_u32(ptr, orig, tmp);
		if (orig = tmp)
			break;
	}

Repeat for u16, etc.

However, for platforms like sparc32 that can do a xchg() atomically
but can't do cmpxchg, this idea won't work :-/
