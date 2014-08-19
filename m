From: Meelis Roos <mroos@linux.ee>
Date: Tue, 19 Aug 2014 14:23:39 +0000
Subject: 3.17-rc1: FATAL RESET from  DAR/DCS/CDX
Message-Id: <alpine.SOC.1.00.1408191719280.7767@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On up to 3.16, my V480 with old revision mainboard sometimes boots up 
and works (onboard cassini not in use because of mainboard bug), 
sometimes it hits schizo PCI error on boot and retry works.

However, with 3.17-rc1, it fails differently and consistently after FC 
scsi, cassini and i2c detection:

[   96.352052] cassini: cassini.c:v1.6 (21 May 2008)
[   96.417822] cassini 0002:00:02.0 eth4: Sun Cassini+ (64bit/33MHz PCI/Cu) Ethernet[28] 00:03:ba:29:66:f2
[   96.546451] cassini 0003:00:01.0 eth5: Sun Cassini+ (64bit/66MHz PCI/Cu) Ethernet[34] 00:03:ba:29:66:f1
[   96.553061] scsi 2:0:0:0: Direct-Access     HITACHI  DK32EJ72FSUN72G  2Q0J PQ: 0 ANSI: 3
[   96.776844] i2c-0: Regs at 000007fc7e00002e, 8 devices, own a0, clock 10.
[   96.866112] i2c-0: Regs at 000007fc7e000030, 8 devices, own a0, clock 10.

RSC Alert: Host System has Reset

ERROR: System Hardware FATAL RESET from  DAR/DCS/CDX


System State (CPU3 reporting)

  BBC Devices: 0000.0000.0000.000a
  BBC Arb:     0000.0000.0000.000f
  BBC Quiesce: 0000.0000.0000.0003
  BBC WDogAct: 0000.0000.0000.0000
  BBC POR Gen: 0000.0000.0000.0000
  BBC XIR Gen: 0000.0000.0000.0000
  BBC POR Src: 0000.0000.0000.4000
  BBC XIR Src: 0000.0000.0000.0000
  BBC EBus TC: 014f.99fd.a7e6.3f29

WARNING: CPU0 not in ROM 'IDLE' loop, attempting mailbox command...

Then CPU1 dump, CPU2 not in idle loop, CPU3 dump and

A recursive System/CPU trap or fault has occurred.
No further registers can be meaningfully printed.
Proceeding to attempt system recovery.
3:0>POST is doing a System JTAG SCAN Dump for OBP 




-- 
Meelis Roos (mroos@linux.ee)
