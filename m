From: David Miller <davem@davemloft.net>
Date: Sun, 22 Jul 2007 05:54:13 +0000
Subject: Re: [RFC] Kconfig fun with sparc32/sparc64 rtc drivers
Message-Id: <20070721.225413.23605608.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070720161154.GA17382@infradead.org>
	<20070721.192251.122832397.davem@davemloft.net>
	<20070722054356.GO21668@ftp.linux.org.uk>
In-Reply-To: <20070722054356.GO21668@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, sam@ravnborg.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 22 Jul 2007 06:43:56 +0100

> seems to imply that CONFIG_RTC has no business whatsoever on sparc64 builds,
> let alone in defconfig - JavaStation had never gone sparc64.  OTOH, we
> have explicit scanning ISA bus in addition to EBUS in drivers/char/rtc.c
> in case of __sparc_v9__, so it looks like help above ought to be changed.
> OTTH, the isa-scanning code looks odd - for comparison, FreeBSD has
> the same logics for ebus (looks for node called "rtc"), but the isa probe
> in the same driver (sys/sparc64/sparc64/rtc.c) is

It doesn't get built on sparc64 any more.

If you look at the current tree:

1) we handle all of the sparc64 RTC stuff in arch/sparc64/kernel/time
2) all the __sparc_v9__ crap is removed from drivers/char/rtc.c
3) all the __sparc__ crap is changed to CONFIG_SPARC32 in same
4) CONFIG_RTC is not longer allows on sparc64, only sparc32 with PCI
