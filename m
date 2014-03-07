From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 07 Mar 2014 14:29:38 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <20140307142938.GG8637@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <341392153219@web17g.yandex.ru>
 <52FB2751.2070101@oracle.com>
 <173231392194038@web29j.yandex.ru>
 <20140304.145523.176895354551282596.davem@davemloft.net>
In-Reply-To: <20140304.145523.176895354551282596.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tkhai@yandex.ru, allen.pais@oracle.com, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org

* David Miller | 2014-03-04 14:55:23 [-0500]:

>PowerPC does the same exact thing with arch_enter_lazy_mmu_mode(), in
>fact that's where I copied the logic from.  Does PowerPC not work with
>-rt? :-)

It is only PPC64 as far as I can see and I have mostly 32bit book-e
around. That preempt-lazy stuff also touches PPC64 bits so I assume
PPC64 works.

Sebastian
