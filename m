From: David Miller <davem@davemloft.net>
Date: Mon, 17 Aug 2009 01:26:18 +0000
Subject: Re: [PATCH] sparc64: cheaper asm/uaccess.h inclusion
Message-Id: <20090816.182618.198968152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090813200543.GA2376@x200.localdomain>
In-Reply-To: <20090813200543.GA2376@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 14 Aug 2009 00:05:43 +0400

> sched.h inclusion is definitely not needed like in 32-bit version,
> remove it, fixup compilation.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Looks good, applied.

Thanks!
