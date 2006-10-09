From: David Miller <davem@davemloft.net>
Date: Mon, 09 Oct 2006 08:21:56 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061009.012156.74743442.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 8 Oct 2006 19:29:54 -0700

> We have two reports now of boot failures of 2.6.18 on SunBlade 100 and 
> 150. According to the reporters (who are CC'd), they see the following 
> during boot:
> 
> Booting Linux...
> NVRAM: Low Battery Voltage!
> CLOCK: Clock was stopped. Kick start
> 
> Then machine hangs. Any ideas on how to fix it will be appreciated.

It's probably a device probing regression caused by the
new in-kernel device tree code I added to 2.6.18

I'll try to hook up my SB100 and see if I can reproduce.
