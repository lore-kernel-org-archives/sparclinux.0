From: David Miller <davem@davemloft.net>
Date: Thu, 18 Dec 2014 17:48:11 +0000
Subject: Re: [PATCH] sparc32: destroy_context() and switch_mm() needs to disable interrupts.
Message-Id: <20141218.124811.1240082913671950177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1418905403-11154-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1418905403-11154-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Thu, 18 Dec 2014 13:23:23 +0100

> Load balancing can be triggered in the critical sections protected by
> srmmu_context_spinlock in destroy_context() and switch_mm() and can hang
> the cpu waiting for the rq lock of another cpu that in turn has called
> switch_mm hangning on srmmu_context_spinlock leading to deadlock.
> 
> So, disable interrupt while taking srmmu_context_spinlock in
> destroy_context() and switch_mm() so we don't deadlock.
> 
> See also commit 77b838fa1ef0 ("[SPARC64]: destroy_context() needs to disable
> interrupts.")
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Looks good, applied, thanks Andreas.
