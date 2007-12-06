From: David Miller <davem@davemloft.net>
Date: Thu, 06 Dec 2007 13:52:21 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071206.055221.224266061.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Thu, 06 Dec 2007 13:09:18 +0100

> ERROR(0): Cheetah error trap taken afsr[0000100000000000]
> afar[0000040001c00000] TL1(0)
> ERROR(0): TPC[4351dc] TNPC[4351e0] O7[4353b4] TSTATE[80001606]
> ERROR(0): TPC<interpret_one_decode_reg+0x0/0xfc>

I'm pretty sure I know what is causing this, thanks for
the log.

I'll work on a fix after I get some sleep.

Thanks again.
