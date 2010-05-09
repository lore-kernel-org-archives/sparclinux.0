From: Igor Kovalenko <igor.v.kovalenko@gmail.com>
Date: Sun, 09 May 2010 06:39:00 +0000
Subject: sparc64: atapi pio mode lost interrupt
Message-Id: <AANLkTim3QMFYkheq20g-M1N0DiCi9LZPjtRmZk96AwMy@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

In qemu-system-sparc64 run I see an issue with cdrom access in PIO mode.

Passing ATAPI packets in PIO mode requires two interrupts, first
interrupt indicates start of packet transmission so host can start PIO
reads/writes, and the second interrupt indicates end of packet
transmission. If ide-cd driver cdrom_newpc_intr is not invoked upon
receipt of second interrupt it fails to finalize transmission, and
eventually I see "hdc: lost interrupt"

Second interrupt happens to be generated while cdrom_newpc_intr is
reading last byte of PIO data packet. Hardware interrupt handler then
schedules softint which is delayed because interrupts are still
disabled. When cdrom_newpc_intr returns back to ide_intr the latter
enables interrupts. At this point nothing blocks softirq handler so it
is reentered. Now handle_fasteoi_irq skips calling handler since
IRQ_INPROGRESS is set in irq handler descriptor because we are still
in the handler of first interrupt. If I set IRQF_DISABLED in ide port
flags then interrupts are not reenabled by ide_intr and second
interrupt is not missed.

Not sure if this issue can be seen on real hardware, since it depends
on PIO interrupt timing. If handlers happen to return before drive
asserts second interrupt there is no issue. Still since interrupts are
enabled there may be extra delay before returning from ide handler due
to timer handlers etc..

In case ide drivers operate as designed we may want to change qemu
code so it delays interrupt generation.

I use latest checkout of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-2.6 to run
kernel in qemu-system-sparc64.

-- 
Kind regards,
Igor V. Kovalenko
