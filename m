From: David Miller <davem@davemloft.net>
Date: Tue, 08 Nov 2011 19:01:53 +0000
Subject: Re: [PATCH] sunhme: Allow usage on SBI based SBus systems
Message-Id: <20111108.140153.2073990811396907800.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1111072217540.4069@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1111072217540.4069@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: oftedal@gmail.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Mon, 7 Nov 2011 22:47:53 +0100 (CET)

> To prevent the SBus driver for Sun Happy Meal cards from being loaded for 
> PCI cards utilizing the same chipset, a filter was added to the probe 
> function in commit 0b492fce3d72d982a7981905f85484a1e1ba7fde.
> 
> The filter was implemented by checking the name of the parent node in 
> the OF tree. This patch extends this filter, so that the driver will 
> load on SBus systems that are based upon SBI SBus Bridges.
> 
> Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>

Applied, thanks.
