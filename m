From: David Miller <davem@davemloft.net>
Date: Mon, 02 Mar 2015 05:43:22 +0000
Subject: Re: [PATCH V3] sparc64: fatal trap should stop all cpus
Message-Id: <20150302.004322.1708526836532372322.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 06 Jan 2015 18:31:39 -0600

> "echo c > /proc/sysrq-trigger" does not result in a system crash. There
> are two problems. One is that the trap handler ignores the global
> variable, panic_on_oops. The other is that smp_send_stop() is a no-op
> which leaves the other cpus running normally when one cpu panics.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

This looks good, thanks for following up on this.

Applied, thanks again.
