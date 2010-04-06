From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 17:54:41 +0000
Subject: Re: [patch 0/3] IRQ disable vs NMI
Message-Id: <20100406.105441.99879289.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406132807.698467930@chello.nl>
In-Reply-To: <20100406132807.698467930@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.p.zijlstra@chello.nl
Cc: mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 06 Apr 2010 15:28:07 +0200

> This patch set tries to solve the local_irq_disable() vs NMI problem
> that SPARC has by providing new arch hooks and instrumenting the
> existing interface to WARN on conflicting usage.

Thanks Peter, looks good at first sight.

I'll toss together the sparc bits and give this a go.
