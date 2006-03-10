From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 10 Mar 2006 10:55:33 +0000
Subject: Re: [Patch] BUG_ON() Conversion in arch/sparc/kernel/ioport.c
Message-Id: <20060310.025533.71195150.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
Date: Thu, 26 Jan 2006 20:12:04 +0100

> this changes if() BUG(); constructs to BUG_ON() which is
> cleaner and can better optimized away
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Patch applied, thanks Eric.
