From: mroos@linux.ee
Date: Wed, 19 Sep 2012 07:51:52 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <alpine.SOC.1.00.1209191049200.13066@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee> <1346950551.30263.196.camel@thor.local> <20120906.141823.13429356729572330.davem@davemloft.net> <CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com>
In-Reply-To: <CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: David Miller <davem@davemloft.net>, michel@daenzer.net, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

> we should just skip the igp reading function on not-x86, since IGP on
> not x86 makes no sense.

I #ifdef'ed out the igp part with CONFIG_X86. This time it got to
[drm] radeon: ring at 0x000001FF0C002000
and stopped here. Some printks showed the actual hang happens in
radeon_ring_commit() with the line

(void)RREG32(ring->wptr_reg);

Any ideas where to continue here?

-- 
Meelis Roos (mroos@linux.ee)
