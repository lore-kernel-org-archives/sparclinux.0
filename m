From: "George Spelvin" <linux@horizon.com>
Date: Thu, 28 Apr 2016 19:15:51 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428191551.17438.qmail@ns.horizon.com>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <20160428175843.GZ21636@brightrain.aerifal.cx>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> How does a CPU lack an efficient ffs/ctz anyway? There are all sorts
> of ways to implement it without a native insn, some of which are
> almost or just as fast as the native insn on cpus that have the
> latter. On anything with a fast multiply, the de Bruijn sequence
> approach is near-optimal, and otherwise one of the binary-search type
> approaches (possibly branchless) can be used. If the compiler doesn't
> generate an appropriate one for __builtin_ctz, that's arguably a
> compiler bug.

What's wanted here is something faster than any of those.
Yes, there's a simple constant-time branch-free implementation:

unsigned inline __attribute__((const))
hweight32(uint32_t x)
{
	x -= (x >> 1) & 0x55555555;
	x  = ((x >> 2) & 0x33333333) + (x & 0x33333333);
	x += x >> 4;
	x &= 0x0f0f0f0f;
	x += x >> 8;
	x += x >> 16;
	return x & 63;
}

unsigned inline __attribute__((const))
__ffs32(uint32_t x)
{
	return hweight(~x & (x-1));
}

but if you work it through, that's about 19 instructions; a few more on
platforms without 32-bit immediates.  The shift itself makes an even 20,
and there are a lot of sequential dependencies (I count a 17-op chain
including the shift) limiting execution time.

The de Bruijn hack reduces the length but adds a memory access for
the table lookup.  (http://supertech.csail.mit.edu/papers/debruijn.pdf)

In the GCD code, the number to normalize is basically random, so the
normalization loop shifts an average of 1 bit.  One bit half the time,
a second bit 1/4 of the time, etc.

(The posted code in the FAST_FFS case omits one guaranteed shift at the
end of the loop because the normalization code is constant-time.)

So "fast __ffs" basically means faster than *one* iteration of
"while (!(x & 1)) x >>= 1;".

In this case "fast" means cheaper than *one* unpredictable branch, which
is a very small handful of instructions.
