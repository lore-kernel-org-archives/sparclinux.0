From: David Miller <davem@davemloft.net>
Date: Fri, 09 Oct 2009 22:08:29 +0000
Subject: Re: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <20091009.150829.218507309.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
	<505766fa0909230040m13e3dc34x2ceb83848767d825@mail.gmail.com>
	<505766fa0909231903t2fe2f7b6y26d2681d6d38ef0e@mail.gmail.com>
In-Reply-To: <505766fa0909231903t2fe2f7b6y26d2681d6d38ef0e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: heyongli@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: hyl <heyongli@gmail.com>
Date: Thu, 24 Sep 2009 10:03:25 +0800

> Subject: [PATCH] Sun ldom vnet driver dead lock
> 
> if 2 vnet attach to same vswitch, ldom will report
> 2 same irq then lead to dead lock on the lp->lock
> or the vio->lock
> 
> static irqreturn_t ldc_rx(int irq, void *dev_id){
> ...
> out:
> 	spin_unlock_irqrestore(&lp->lock, flags);
>            << here run with out any lock
> 	send_events(lp, event_mask);
>            >> vnet evetn process will dead lock on
>            >> lp->lock or the vio->lock
> 
> Signed-off-by: Yongli He <heyongli@gmail.com>

Thank you for this bug report and patch, I am looking at
it now.
