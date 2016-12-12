From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 02:18:35 +0000
Subject: Re: [patch] sparc64: make string buffers large enough
Message-Id: <20161211.211835.269565767787847661.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 14:03:55 +0300

> My static checker complains that if "lvl" is ULONG_MAX (this is 64 bit)
> then some of the strings will overflow.  I don't know if that's possible
> but it seems simple enough to make the buffers slightly larger.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
