From: David Miller <davem@davemloft.net>
Date: Mon, 09 Mar 2009 03:14:15 +0000
Subject: Re: sunhme: SBUS QFE not detected anymore
Message-Id: <20090308.201415.224158966.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B4632D.7010606@gentoo.org>
In-Reply-To: <49B4632D.7010606@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@gentoo.org>
Date: Mon, 09 Mar 2009 01:30:37 +0100

> my Ultra 2 has a SBUS Happy Meal and a SBUS Quad FastEthernet, both used
> to work fine but the qfe is no longer detected since:
> 
> 0b492fce3d72d982a7981905f85484a1e1ba7fde
> sunhme: Don't match PCI devices in SBUS probe.
 ...
> According to prtconf [0] the tree looks like this:
> 
> SUNW,Ultra-2
>   sbus
>     SUNW,hme
>     SUNW,qfe
>     SUNW,qfe
>     SUNW,qfe
>     SUNW,qfe
 ...
> I attached a patch :)

Patch applied, thanks a lot!
