From: David Miller <davem@davemloft.net>
Date: Wed, 03 Oct 2012 03:21:16 +0000
Subject: Re: [PATCH] sparc: fix format string argument for prom_printf()
Message-Id: <20121002.232116.122012572233576766.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 29 Sep 2012 22:14:49 +0900

> prom_printf() takes printf style arguments.  Specifing GCC's format
> attribute reveals that there are several wrong usages of prom_printf().
> 
> This fixes those wrong format strings and arguments, and also leaves
> format attributes in order to detect similar mistakes at compile time.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied, thank you.
