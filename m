From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jul 2017 18:38:20 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170710.193820.2050702339497538290.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: jane.chu@oracle.com
Date: Mon, 10 Jul 2017 10:23:32 -0700

> Sorry for my delay in reply.  My colleague saw mondo timeout while
> performing
> PCIe hotplug tests.  The timeout came from a network thread sending a
> mondo to
> a single cpu to raise software interrupt.  Occasionally, the target
> cpu made no
> progress in 20msec.  The reason I think, is that the target cpu was
> borrowed
> by hypervisor to service the correctable errors triggered by hotplug.
> As strand in hypervisor service cannot respond to mondo, we need to
> increase the
> overall wait time to an agreeable value between hypervisor and OS.
> 
> I will revise the patch and fix the variable types.

Ok, thanks for the update and additional information.
