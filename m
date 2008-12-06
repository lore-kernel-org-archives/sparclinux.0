From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:04:55 +0000
Subject: [PATCH 0/14]: Commonization of OF device tree code.
Message-Id: <20081205.190455.152563946.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This tries to split out as much common code from
arch/sparc/kernel/prom_{32,64}.c as possible.

There is an ugly ifdef or two left in the new
prom_common.c but that once I can fix at some
point by rejigging the 32-bit prom_firstprop() et al.
oplib interfaces.

All of this work has been build tested on both
ports and pushed out to sparc-next-2.6 on kernel.org
