From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 02:14:41 +0000
Subject: Re: [PATCH] sparc: delete unused config symbols
Message-Id: <20090102.181441.193694037.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 26 Dec 2008 00:47:35 +0100

> There is no need to define a config symbol if
> it is never set to any value. Undefined symbols equal
> to 'n'.
> 
> GENERIC_GPIO looks like it is similar but
> it is set using select in some other file so
> it must be kept.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
