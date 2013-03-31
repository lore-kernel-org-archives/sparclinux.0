From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:31:17 +0000
Subject: Re: [PATCH] sparc/srmmu: clear trailing edge of bitmap properly
Message-Id: <20130331.193117.1100871984855844394.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364564684-15469-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364564684-15469-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 29 Mar 2013 22:44:43 +0900

> srmmu_nocache_bitmap is cleared by bit_map_init().  But bit_map_init()
> attempts to clear by memset(), so it can't clear the trailing edge of
> bitmap properly on big-endian architecture if the number of bits is not
> a multiple of BITS_PER_LONG.
> 
> Actually, the number of bits in srmmu_nocache_bitmap is not always
> a multiple of BITS_PER_LONG.  It is calculated as below:
> 
>         bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
> 
> srmmu_nocache_size is decided proportionally by the amount of system RAM
> and it is rounded to a multiple of PAGE_SIZE.  SRMMU_NOCACHE_BITMAP_SHIFT
> is defined as (PAGE_SHIFT - 4).  So it can only be said that bitmap_bits
> is a multiple of 16.
> 
> This fixes the problem by using bitmap_clear() instead of memset()
> in bit_map_init() and this also uses BITS_TO_LONGS() to calculate correct
> size at bitmap allocation time.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied.
