From: David Miller <davem@davemloft.net>
Date: Tue, 28 Mar 2017 04:47:28 +0000
Subject: Re: [PATCH v2 0/4] Improved logging
Message-Id: <20170327.214728.1973448231414057241.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1489423479-654395-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1489423479-654395-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 13 Mar 2017 12:44:35 -0400

> Changes from v1 - v2:
> Two small nits:
> - "Reviewed-by" is fixed in two patches,
> - Fixed comment before __weak plat_unregister_bootcon(): of -> if.
> 
> This patch set does the following improvements:
> 1. Get time stamps available early in boot
> 2. Removes duplicated output on console during boot
> 3. Removes a dead zone, where after tty0 nothing is printed until
>    ttyHV is regested; and even if we panic no messages are printed.
> 
> Here is example base output:
> https://hastebin.com/obofesaqek.vbs
> 
> Fixed output:
> https://hastebin.com/ipoxodobaq.vbs

You really need to generalize this, so that it doesn't only just work
with the hypervisor console, but rather with any console device we
support whatsoever.

I bet if you did that, the hook wouldn't even be needed.

If you need to keep the hook, you have to declare it in some common
kernel header file.  If you built with extra warnings or with sparse
it would have warned about this (globally visible function with no
previous declaration seen).

