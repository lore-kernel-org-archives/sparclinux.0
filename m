From: David Miller <davem@davemloft.net>
Date: Thu, 02 Aug 2007 04:56:07 +0000
Subject: Re: [Patch]: Minor fixes for CS4231 on SBus
Message-Id: <20070801.215607.102772078.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Tue, 31 Jul 2007 22:18:43 +0200

> Hello,
> 
> remove unnecessary sbus_dma_reset function and
> change sbus_dma_enable to avoid occasional system
> crashes when stopping recording. Patch is against
> 2.6.22-rc5 but applies cleanly to 2.6.23-rc1.
> Tested on my ultra2.

Patch applied, thanks.
