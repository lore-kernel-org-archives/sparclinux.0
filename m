From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 17 Sep 2013 13:23:37 +0000
Subject: [sparc64] Sparse cpu_possible_mask
Message-Id: <275591379424217@web19h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, David, hi everyone!

I booted recent kernel on Ultra2, while probing CONFIG_RCU_NOCB_CPU_ALL option
enabled, and found that cpu_possible_mask is sparse. The cpuinfo is:
CPU0:		online
CPU2:		online

Other info is:
PROMLIB: Sun IEEE Boot Prom 'OBP 3.11.25 1998/01/16 12:22'
Sun Ultra 60 UPA/PCI (2 X UltraSPARC-II 296MHz)

Who knows what's the reason of it's sparse?

This question appeared here (no the first in the thread, looks like lkml ignores
messages with 'E.'):

https://lkml.org/lkml/2013/9/14/131

Kirill
