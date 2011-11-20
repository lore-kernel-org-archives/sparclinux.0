From: David Miller <davem@davemloft.net>
Date: Sun, 20 Nov 2011 22:35:49 +0000
Subject: Re: [PATCH][RFC] add SPARC support to i2c-ali1535
Message-Id: <20111120.173549.106523432422599342.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Thu, 25 Aug 2011 11:32:55 +0200

> Signed-off-by: LABBE Corentin <corentin.labbe@geomatys.fr>
> ---
> --- linux/drivers/i2c/busses/i2c-ali1535.c.orig	2011-06-15
> 18:02:56.000000000 +0200
> +++ linux/drivers/i2c/busses/i2c-ali1535.c	2011-06-15 18:05:26.000000000
> +0200
> @@ -132,7 +132,7 @@

This seems like a pretty reasonable patch.  But could you please repost it in a way
such that your email client doesn't break up long lines and otherwise corrupt
the patch as it has done here?

Please make a fresh, formal, new posting of the patch.  Complete with a sufficiently
detailed commit log message and appropriate Subject line.

Thanks.
