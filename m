From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Sat, 10 Sep 2005 12:31:38 +0000
Subject: Offlist question: Hardware problem with ultra2
Message-Id: <4322D22A.9000308@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I have an ultra2 machine with a hardware
problem. It runs through POST without errors
and everything seems fine, but it stops soon
after the selftest sequence.
Here are the last things I see:
....
0>CPU Functional Test
0>    Mapping Selftest Enabling MMUs
0>    SPARC Atomic Instructions Test
0>    CPU Dispatch Control Register Test
0>    CPU Softint Registers and Interrupts Test
0>    CPU Tick and Tick Compare Registers Test
0>    Uni-Processor Cache Coherence Test
0>    UltraSPARC-2 Prefetch Instructions Test
0>              *UltraSparc-1 module detected, tests skipped
0>
     << POST COMPLETE >>
0>**Entering OBP (3b)


Power On Selftest Completed
    Status  = 0000.0000.0000.0000 0000.01ff.f007.8bc8 1f66.0000.01c1.0105

Software Power ON

@(#) Sun Ultra 2 UPA/SBus  3.7 Version 0 created 1997/01/09 13:06
Clearing DTAGS 0000.0000.0010.0000 Done
Probing Memory Done
MEM BASE = 0000.0000.0000.0000
MEM SIZE = 0000.0000.0800.0000
MMUs ON
Copy Done
PC = 0000.01ff.f000.2b7c
PC = 0000.0000.0000.2bc0
Decompressing into Memory Done
Size = 0000.0000.0007.2911


Any ideas what might cause this or how to solve the problem?
Thanks a lot in advance.

Regards
              Georg Chini
