From: David Miller <davem@davemloft.net>
Date: Thu, 31 May 2012 23:23:06 +0000
Subject: Re: [PATCH] silo: include stddef.h in stringops.h
Message-Id: <20120531.192306.242165058193646.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1338489215-2047-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1338489215-2047-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 31 May 2012 21:33:35 +0300

> I recompiled toolchain/glibc/everything from scratch against Linux 3.4
> headers and silo won't compile anymore:
> 
> 	file.c:60:5: error: 'NULL' undeclared here (not in a function)
> 	fs/ext2.c:401:7: error: 'NULL' undeclared (first use in this function)
> 	fs/isofs.c:57:45: error: 'NULL' undeclared (first use in this function)
> 	etc.
> 
> Fix by including stddef.h.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied, thanks.
