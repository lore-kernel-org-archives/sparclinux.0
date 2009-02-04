From: David Miller <davem@davemloft.net>
Date: Wed, 04 Feb 2009 09:47:09 +0000
Subject: Re: Kernel unaligned access at TPC
Message-Id: <20090204.014709.208354803.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.2.00.0902041001550.4084@bogon.housecafe.de>
In-Reply-To: <alpine.DEB.2.00.0902041001550.4084@bogon.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lists@nerdbynature.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Christian Kujau <lists@nerdbynature.de>
Date: Wed, 4 Feb 2009 10:07:52 +0100 (CET)

> 
> [   94.099721] Kernel unaligned access at TPC[54c818] nsm_get_handle+0x158/0x400
> [   94.336558] Kernel unaligned access at TPC[54c81c] nsm_get_handle+0x15c/0x400
> [   94.678623] Kernel unaligned access at TPC[54c818] nsm_get_handle+0x158/0x400
> [   94.915452] Kernel unaligned access at TPC[54c81c] nsm_get_handle+0x15c/0x400
> [   95.252917] Kernel unaligned access at TPC[54c818] nsm_get_handle+0x158/0x400
> 
> Searching the net only brought up a post[0] from kernel-testers, but this 
> box here is running fine - no filesystem errors or anything. Are these 
> messages something to worry about or can they be ignored?

You can safely ignore it, but it should get fixed.
