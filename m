From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 06 Apr 2010 13:28:07 +0000
Subject: [patch 0/3] IRQ disable vs NMI
Message-Id: <20100406132807.698467930@chello.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@l>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>


This patch set tries to solve the local_irq_disable() vs NMI problem
that SPARC has by providing new arch hooks and instrumenting the
existing interface to WARN on conflicting usage.

