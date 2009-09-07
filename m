From: David Miller <davem@davemloft.net>
Date: Mon, 07 Sep 2009 00:52:59 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090906.175259.243140550.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: S=E9bastien Bernard <sbernard@nerim.net>
Date: Sun, 06 Sep 2009 23:21:42 +0200

> David said, he'll look this bug later. I'll need to remind him.

In Linus's tree is the following fix for this.  I'll submit it
to -stable when I get a chance.

sparc64: Kill spurious NMI watchdog triggers by increasing limit to 30 seco=
nds.

This is a compromise and a temporary workaround for bootup NMI
watchdog triggers some people see with qla2xxx devices present.

This happens when, for example:

CPU 0 is in the driver init and looping submitting mailbox commands to
load the firmware, then waiting for completion.

CPU 1 is receiving the device interrupts.  CPU 1 is where the NMI
watchdog triggers.

CPU 0 is submitting mailbox commands fast enough that by the time CPU
1 returns from the device interrupt handler, a new one is pending.
This sequence runs for more than 5 seconds.

The problematic case is CPU 1's timer interrupt running when the
barrage of device interrupts begin.  Then we have:

	timer interrupt
	return for softirq checking
	pending, thus enable interrupts

		 qla2xxx interrupt
		 return
		 qla2xxx interrupt
		 return
		 ... 5+ seconds pass
		 final qla2xxx interrupt for fw load
		 return

	run timer softirq
	return

At some point in the multi-second qla2xxx interrupt storm we trigger
the NMI watchdog on CPU 1 from the NMI interrupt handler.

The timer softirq, once we get back to running it, is smart enough to
run the timer work enough times to make up for the missed timer
interrupts.

However, the NMI watchdogs (both x86 and sparc) use the timer
interrupt count to notice the cpu is wedged.  But in the above
scenerio we'll receive only one such timer interrupt even if we last
all the way back to running the timer softirq.

The default watchdog trigger point is only 5 seconds, which is pretty
low (the softwatchdog triggers at 60 seconds).  So increase it to 30
seconds for now.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/nmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 2c0cc72..b75bf50 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -103,7 +103,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_r=
egs *regs)
 	}
 	if (!touched && __get_cpu_var(last_irq_sum) =3D sum) {
 		local_inc(&__get_cpu_var(alert_counter));
-		if (local_read(&__get_cpu_var(alert_counter)) =3D 5 * nmi_hz)
+		if (local_read(&__get_cpu_var(alert_counter)) =3D 30 * nmi_hz)
 			die_nmi("BUG: NMI Watchdog detected LOCKUP",
 				regs, panic_on_timeout);
 	} else {
--=20
1.6.4.2

