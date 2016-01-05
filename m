From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jan 2016 03:06:22 +0000
Subject: Re: linux-4.4-rc8/arch/sparc/kernel/pcic.c:785: possible int/long mixup ?
Message-Id: <20160104.220622.1166874009341937754.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Binderman <dcb314@hotmail.com>
Date: Mon, 4 Jan 2016 09:02:34 +0000

> Hello there,
> 
> [linux-4.4-rc8/arch/sparc/kernel/pcic.c:785]: (style) int result is returned as long value. If the return value is long to avoid loss of information, then you have loss of information.

Sparc 32-bit has both long and int the same size, and yes IRQ numbers are limited
to be below (1 << 32) -1.
