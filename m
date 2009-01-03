From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 02:39:28 +0000
Subject: Re: [PATCH] sparc32: drop __old_kernel_stat
Message-Id: <20090102.183928.64220579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Dec 2008 21:44:30 +0100

> sparc32 do not define __ARCH_WANT_OLD_STAT so
> we do not use this structure neither do we support it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Looks good, applied.
