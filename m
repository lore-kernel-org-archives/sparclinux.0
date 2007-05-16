From: David Miller <davem@davemloft.net>
Date: Wed, 16 May 2007 19:22:41 +0000
Subject: Re: parport_pc BUG in dma-mapping.h
Message-Id: <20070516.122241.27953056.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121525460.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121525460.4493@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 May 2007 20:32:38 +0300 (EEST)

> Unfortunately it does not seems to fix it.

Thanks I'll look more deeply into this.

> BUG: at include/linux/slub_def.h:89 kmalloc_index()

This problem is known and a fix is being worked on.
