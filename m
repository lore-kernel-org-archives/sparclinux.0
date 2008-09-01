From: David Miller <davem@davemloft.net>
Date: Mon, 01 Sep 2008 04:16:55 +0000
Subject: [PATCH 0/2]: Rewrite central driver
Message-Id: <20080831.211655.250744471.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The sparc64 central driver for SUNW,Ultra-Enterprise starfire
servers was doing several things, some of which are now
unnecessary:

1) IRQ register initialization, which is now handled entirely
   in the IRQ controller mini-driver in
   arch/sparc64/kernel/of_device.c

2) Basic programming of per-board registers, such as setting
   the "I exist" bit in non-central FHC controllers, clearing
   the firmware semaphore, and clearing the power state bits.

3) LED blink

#1 can be deleted, and #2 and #3 can be simplified and cleaned
up massively.

What happens now is that there is a new LED layer driver for
the sunfire LEDs.  Then a top-level FHC/clock-board driver
programs the chips and creates the platform_device objects
which will get used by the LED driver.
