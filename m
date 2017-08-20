From: David Miller <davem@davemloft.net>
Date: Sun, 20 Aug 2017 05:01:38 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170819.220138.235199150058320061.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
 <20170820144553.2ab2727b@ppc64le>
In-Reply-To: <20170820144553.2ab2727b@ppc64le>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 20 Aug 2017 14:45:53 +1000

> [PATCH] timers: Fix excessive granularity of new timers after a nohz idle

I just booted into this on my sparc64 box, let's see if it does the
trick :-)
