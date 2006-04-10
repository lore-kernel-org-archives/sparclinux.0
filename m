From: Christophe Jacquet <jacquetc@free.fr>
Date: Mon, 10 Apr 2006 15:49:38 +0000
Subject: PCI card problem on a Sun Ultra 10
Message-Id: <1144684178.443a7e9215d7d@imp5-g19.free.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I tried to plug a PCI card on a Sun Ultra 10, whose purpose is to provide an
additional parallel port.

When booting, Linux stopped with an error message. I am posting the message here
to provide feedback to the community, as well as to possibly get some ideas to
solve the issue.

---
ok boot
Boot device: disk  File and args:
SILO Version 1.4.10
boot:
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.15
Loading initial ramdisk (6381383 bytes at 0x10800000 phys, 0x40C00000 virt)...
/
Remapping the kernel... done.
Booting Linux...
PCI: Bogus PROM assignment. BUS[02] DEVFN[8]
PCI: phys[81020810:00000000:00000400] size[00000000:00000008]
PCI: RES[0000000000000440-->0000000000000447:(101)]
Please email this information to davem@redhat.com
Program terminated
ok
---

Note that I have experienced stability problems using this card
on a PC: it randomly caused the PC to crash, and even
prevented it from booting sometimes. Otherwise, the PCI card worked fine.

Regards,

Christophe Jacquet.
