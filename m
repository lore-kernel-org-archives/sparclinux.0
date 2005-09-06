From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 06 Sep 2005 01:57:54 +0000
Subject: Re: PCI device issues between Blade 100 and Blade 100
Message-Id: <20050905.185754.72907624.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050904153024.630204cb@enterprise.weeve.org>
In-Reply-To: <20050904153024.630204cb@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Mon, 5 Sep 2005 09:41:31 -0600

> Looking at the ehci driver messages, it shows (among other things);
> ehci_hcd 0001:00:01.2: request interrupt 10,20e failed
> 
> Then looking for interrupt 10 in /proc/interrupts shows;
> 10:          0          0  rtc:224

Give this a spin:

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -941,7 +941,7 @@ found:
 	 * PCI Slot 2 INTA# (and some INTx# in Slot 1). SA_INTERRUPT here
 	 * is asking for trouble with add-on boards. Change to SA_SHIRQ.
 	 */
-	if (request_irq(rtc_irq, rtc_interrupt, SA_INTERRUPT, "rtc", (void *)&rtc_port)) {
+	if (request_irq(rtc_irq, rtc_interrupt, SA_SHIRQ, "rtc", (void *)&rtc_port)) {
 		/*
 		 * Standard way for sparc to print irq's is to use
 		 * __irq_itoa(). I think for EBus it's ok to use %d.
