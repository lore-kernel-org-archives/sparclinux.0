From: David Miller <davem@davemloft.net>
Date: Mon, 25 Mar 2013 17:50:36 +0000
Subject: Re: [PATCH 2/3] sparc/iommu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <20130325.135036.166152809650425467.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 24 Mar 2013 17:55:05 +0900

> The size of bitmaps which is accessed by bitops must be a multiple of
> the sizeof(long).  So it would be better to use BITS_TO_LONGS() to
> calculate the bitmap size although IOMMU_NPTES is a multiple of
> BITS_PER_LONG.
> 
> This also fixes typo in the comment for IOMMU_NPTES.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Again, I'd rather not fix non-bugs.

You've also corrupted the indentation of the prom_printf() calls,
the arguments to a function should line up with the first column
after the openning parenthesis of the function call.

It was correct before your patch, it will be wrong afterwards.

But I don't want to apply this patch anyways, so don't bother
resubmitting the fixed version.

Thanks.
