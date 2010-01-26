From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 26 Jan 2010 09:23:06 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <a4423d671001260123r7013a92fqb007e4f255e8b3ba@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100125.165644.197238824.davem@davemloft.net>
In-Reply-To: <20100125.165644.197238824.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David

> 7) IRQ ->set_affinity() using wrong cpu mask, thanks to Ben H. for
>   noticing.
>      sparc64: Fix IRQ ->set_affinity() methods.

This commit breaks UP build

arch/sparc/kernel/irq_64.c: In function 'sun4u_irq_enable':
arch/sparc/kernel/irq_64.c:286: error: 'struct irq_desc' has no member
named 'affinity'
arch/sparc/kernel/irq_64.c: In function 'sun4v_irq_enable':
arch/sparc/kernel/irq_64.c:362: error: 'struct irq_desc' has no member
named 'affinity'
arch/sparc/kernel/irq_64.c: In function 'sun4v_virq_enable':
arch/sparc/kernel/irq_64.c:425: error: 'struct irq_desc' has no member
named 'affinity'
