From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 26 Mar 2013 09:17:16 +0000
Subject: Re: [PATCH 3/3] sparc/srmmu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <CAC5umyjyKx-+O1kcKbY1-pa073pTLRewVWz0G2rTjDq8_ex7cA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1364115306-17716-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364115306-17716-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2013/3/26 David Miller <davem@davemloft.net>:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> Date: Sun, 24 Mar 2013 17:55:06 +0900
>
>> The size of bitmaps which is accessed by bitops must be a multiple of
>> the sizeof(long).  So it would be better to use BITS_TO_LONGS() to
>> calculate the bitmap size although it always be a multiple of the
>> sizeof(long)
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> Same objection as patch #2, fixing a non-bug.

I thought it wasn't bug, but I was confused with bits and bytes, now
I realize that bitmap_bits is not always a multiple of the BITS_PER_LONG.
Because the value is set as below:

        bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;

srmmu_nocache_size is decided proportionally by the amount of system RAM
and it is rounded to a multiple of PAGE_SIZE.  SRMMU_NOCACHE_BITMAP_SHIFT
is defined as (PAGE_SHIFT - 4).  So it can only be said that bitmap_bits
is a multiple of 16.

So this patch (and patch 1/3) actually fix a bug.  I'll update the commit
messages and resend only the patches that fixing bug.
