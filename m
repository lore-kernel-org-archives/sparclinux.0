From: Bob Breuer <breuerr@mc.net>
Date: Mon, 28 Feb 2005 00:47:02 +0000
Subject: Re: sparc32 SMP for 2.6
Message-Id: <42226A06.5010009@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <420F070B.8010000@mc.net>
In-Reply-To: <420F070B.8010000@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I was able to narrow down a couple problems.

- scsi problems
also exists with a UP kernel, seems to be CONFIG_SCSI=m and
CONFIG_SCSI_MULTI_LUN=y that causes it.

- init hangs from serial console
I had a bug in synchronize_irq, drop this version in instead:

void synchronize_irq(unsigned int irq)
{
	unsigned int cpu_irq;

	cpu_irq = irq & (NR_IRQS - 1);
	while (sparc_irq[cpu_irq].flags & IRQ_INPROGRESS)
		cpu_relax();
}

- only cpu #0 handles interrupts
Need to implement smp4m_irq_rotate().

Bob
