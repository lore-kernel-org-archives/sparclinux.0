From: David Miller <davem@davemloft.net>
Date: Mon, 25 Mar 2013 17:50:53 +0000
Subject: Re: [PATCH 3/3] sparc/srmmu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <20130325.135053.528292024762685239.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364115306-17716-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364115306-17716-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 24 Mar 2013 17:55:06 +0900

> The size of bitmaps which is accessed by bitops must be a multiple of
> the sizeof(long).  So it would be better to use BITS_TO_LONGS() to
> calculate the bitmap size although it always be a multiple of the
> sizeof(long)
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Same objection as patch #2, fixing a non-bug.

I'm not applying this, sorry.
