From: Bill Geddes <bill@wgeddes.com>
Date: Thu, 19 Feb 2004 21:49:16 +0000
Subject: smp for sparc linux
Message-Id: <1077227356.1503.53.camel@pavlov.wgeddes.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have attempted to get the 2.6.2 linux sources compiled on my sparc
linux machines - with the same failure 'include/asm/hardirq.h:147:
`BR_GLOBALIRQ_LOCK' undeclared (first use in this function) '

Is a SMP linux kernel going to be possible for this architecture?
Here is the output from /proc/cpuinfo on my machine:

cpu		: TI UltraSparc IIi
fpu		: UltraSparc IIi integrated FPU
promlib		: Version 3 Revision 14
prom		: 3.14.0
type		: sun4u
ncpus probed	: 1
ncpus active	: 1
Cpu0Bogo	: 599.65
Cpu0ClkTck	: 0000000011e18f87
MMU Type	: Spitfire



Thank you.
-- 
Bill Geddes bill at wgeddes dot com>

