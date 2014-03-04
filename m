From: David Miller <davem@davemloft.net>
Date: Tue, 04 Mar 2014 19:59:23 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <20140304.145923.1615081983757728942.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <173231392194038@web29j.yandex.ru>
	<52FB5AEF.3040807@oracle.com>
	<341861392205386@web5h.yandex.ru>
In-Reply-To: <341861392205386@web5h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tkhai@yandex.ru
Cc: allen.pais@oracle.com, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org, bigeasy@linutronix.de

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 12 Feb 2014 15:43:06 +0400

> For example, collect only batches which does not require smp call function. Or the
> main goal of lazy tlb was to prevent smp calls?! It's good to discover this..

The goal of the lazy tlb stuff is to only have one (potential)
synchronization point with other cpus.

Then we sweep away the TSB entries, after which any TLB miss must
enter the full fault path and synchronize with the current thread
doing the flush.

Then we kill the TLB entries, both local and remote.

The tsb_grow() code path is quite the animal, as any of you who have
read the comment above it's implementation can attest :-) It took 6
months to get that code right in a non-RT context back when it was
originally written.
