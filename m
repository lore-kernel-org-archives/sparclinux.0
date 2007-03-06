From: David Miller <davem@davemloft.net>
Date: Tue, 06 Mar 2007 05:35:15 +0000
Subject: [PATCH 0/4]: clocksource/clockevents for sparc64
Message-Id: <20070305.213515.48527767.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


Here is a sequence of 4 patches that add support for dynticks
and high-resolution timers on sparc64.  I've tested this on
SunBlade1500 and a Niagara T1000 system.  I'm about to do
some tests on SunBlade100 as that has the other primary TICK
hardware type.

Any feedback or testing results are appreciated.  All patches
are against Linus's current tree.

Thanks.
