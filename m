From: David Miller <davem@davemloft.net>
Date: Sat, 19 Apr 2008 00:48:08 +0000
Subject: Re: PCIe Graphic card for SPARC T1000/2000 Platform
Message-Id: <20080418.174808.160025537.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47ED8CBC.8050900@Sun.COM>
In-Reply-To: <47ED8CBC.8050900@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nasser Shayesteh <Nasser.Shayesteh@Sun.COM>
Date: Fri, 18 Apr 2008 17:32:38 -0700

> Booting Linux...
> Debug=Geting out of paging_init routine ...
> 
> System hangs here. Never gets to [ 59.563844] rtc_init: no PC rtc found]

You'll get more debugging information if you boot with
"ignore_loglevel" on the kernel boot command line.

Adding "-p" can help too, which forces printing every kernel message
via the openfirmware console output routines.
