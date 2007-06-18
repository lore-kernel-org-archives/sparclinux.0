From: seb@frankengul.org
Date: Mon, 18 Jun 2007 15:20:45 +0000
Subject: Blade2K and qla2xxx
Message-Id: <20070618152045.GA3451@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have a problem to report.
Kernel 2.6.18 is the last kernel working with the Blade 2000 I was trying to run.

Kernel 2.6.22-rc5 I just recompiled oops at disk detection :

I'm copying the oops by hand since I got no serial output:
------------------------------------------------------
QLogic Fibre Channel HBA Driver
PCI: enabling device (0001:00:04.0), cmd 3
qla2xxx 0001:00:04.0 : Found an ISP2200, irq 21, iobase 0x000007fd00100000
qla2xxx 0001:00:04.0 : Configuring PCI space ...
qla2xxx 0001:00:04.0 : Configure NVRAM parameters...
qla2xxx 0001:00:04.0 : Inconsistent NVRAM detected: checksum=0x0 id=(4)qla2xxx 0001:00:04.0 : Falling back to functionning (yet invalid -- WWPN) defaults
qla2xxx 0001:00:04.0 : Verifying Loaded RISC code...
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controle (OHCI) Driver
eth0: Link is up at 100Mbps, full-duplex.
qla2xxx 0001:00:04.0 : Allocated (252 KB) for firmware dump...
qla2xxx 0001:00:04.0 : LIP reset occured (f8e8).
scsi2 : qla2xxx
qla2xxx 0001:00:04.0 : LIP occured (f8e8).
qla2xxx 0001:00:04.0 : LOOP UP detected (1 Gbps).
 QLogic Fibre Channel HBA Driver : 8.01.07-k7
  QLogic QLA22xx -
   ISP2200: PCI (66 MHz) @ 0001:00:04.1 hdma-, host#3, fw2.02.08 TP
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[14]  MMIO=[7fe00120000-7fe001207ff]  Max Packet=[2048] IR/IT Contexts=[4/4]
ohci_hcd 0000:00:05.3: OHCI Host Controller
ohci_hcd 0000:00:05.3: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:05.3: irq 15, io mem 0x7fe01000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB bus found
hub 1-0:1.0: 4 ports detected
usb 1-3:: new low speed USB device using ohci_hcd and address 2
scsi 2:0:0:0 Direct-Access	SEAGATE  ST373307FSUN72G  0307 PQ:8 ANSI: 3
kobject_add failed for 2:0:0:0 with -EEXIST, don't try to register things with the same name in the same directory.
Call trace:
	[000000001001cc9c] scsi_sysfs_add_sdev+0x2c/0x228 [scsi_mod]
	[000000001001a9ec] scsi_probe_and_add_lun+0x97c/0xab8 [scsi_mod]
	[000000001001b084] __scsi_scan_target+0x90/0x660 [scsi_mod]
	[000000001001bce8] scsi_scan_target+0x94/0xa4 [scsi_mod]
	[000000001007ef70] fc_scsi_scan_rport+0x64/0x98 [scsi_tranport_fc]
	[0000000000465a20] run_workqueue+0xa0/0x11c
	[0000000000465ec0] worker_thread+0xc4/0xd4
	[0000000000469524] kthread+0x4c/0x78
	[00000000004277f8] kernel_thread+0x38/0x48
	[00000000004693d8] kthreadd+0x98/0x100
error 1
sd 2:0:0:0: rejecting I/O from dead device
sd 2:0:0:0: rejecting I/O from dead device
sd 2:0:0:0: rejecting I/O from dead device
sd 2:0:0:0: rejecting I/O from dead device
-------------------------------------------
After this, I got no access from the scsi target.

What do you think the problem can be ?
how to workaround ?

	Seb
