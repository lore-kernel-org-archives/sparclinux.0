From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 19 Dec 2005 22:52:54 +0000
Subject: Re: [2.6 patch] on sparc{,64}, RTC must depend on PCI
Message-Id: <20051219.145254.33863414.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051216222154.GK23349@stusta.de>
	<Pine.LNX.4.64.0512161908460.20531@innerfire.net>
	<20051217141049.GP23349@stusta.de>
In-Reply-To: <20051217141049.GP23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@stusta.de
Cc: gmack@innerfire.net, wli@holomorphy.com, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz, anton@samba.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 17 Dec 2005 15:10:49 +0100

> On sparc and sparc64, the rtc driver doesn't compile with PCI support 
> disabled.

Applied, thanks Adrian.

> BTW: @sparc maintainers:
>      Is there any reason against introducing a SPARC Kconfig symbol
>      that is set on both the sparc and sparc64 architectures?

That's a great idea, I thought we already did this in fact :)
