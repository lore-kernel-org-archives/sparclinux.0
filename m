From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 18 Dec 2013 10:19:25 +0000
Subject: Re: [PATCH 2/3] [RESEND]sparc64: convert spinloc_t to raw_spinlock_t in  mmu_context_t
Message-Id: <52B173DD.1020304@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1387345326-20185-1-git-send-email-allen.pais@oracle.com> <52B16182.9090209@linutronix.de>
In-Reply-To: <52B16182.9090209@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


> Sorry for not noticing this earlier but this has nothing to do with the
> remaining part of the patch.
> To be able to set this flag, you need to mark timer & perf interrupts.
> If you already use IRQF_TIMER for the timer and perf interrupts are
> already coming as NMU then you are done. But please split this out as a
> separate patch.

I'll split this as a separate patch. 

- Allen

