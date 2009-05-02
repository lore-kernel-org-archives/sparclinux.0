From: David Miller <davem@davemloft.net>
Date: Sat, 02 May 2009 16:53:50 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090502.095350.130380048.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 2 May 2009 11:28:05 +0100

> + attachment for real.

It prints "serial"

I suspect that PROM console device driver is getting in the way.

Please take that out of the kernel configuration ASAP.
