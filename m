From: Chris Ricker <kaboom@gatech.edu>
Date: Wed, 14 Jan 2004 22:00:22 +0000
Subject: qlogicpti on 2.6.1
Message-Id: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Does / should the SBUS qlogicpti driver work in the 2.6 kernels?

I've got an SMP ultra2 with a D1000 attached which I've upgraded from 2.4.x
to 2.6. I've gotten everything else working, but when I modprobe qlogicpti
the box detects the disks in the D1000 and then locks hard.

Messages from qlogicpti look sane:

Jan 14 15:49:34 ultra2 kernel: qpti0: IRQ 7,7cb SCSI ID 7 (Firmware 
v1.31.32)(Firmware 1.25 96/10/15) [Ultra Wide, using differential interface]
Jan 14 15:49:34 ultra2 kernel: qpti1: IRQ 7,7d3 SCSI ID 7 (Firmware 
v1.31.32)(Firmware 1.25 96/10/15) [Ultra Wide, using differential interface]
Jan 14 15:49:35 ultra2 kernel: qpti2: IRQ 7,7db SCSI ID 7 (Firmware 
v1.31.32)(Firmware 1.25 96/10/15) [Ultra Wide, using differential interface]
Jan 14 15:49:35 ultra2 kernel: QPTI: Total of 3 PTI Qlogic/ISP hosts found, 
3 actually in use.
Jan 14 15:49:35 ultra2 kernel: scsi1 : PTI Qlogic,ISP SBUS SCSI irq 7,7cb 
regs at 1ff10010000
Jan 14 15:49:37 ultra2 kernel: scsi2 : PTI Qlogic,ISP SBUS SCSI irq 7,7d3 
regs at 1ff20010000
Jan 14 15:49:37 ultra2 kernel:   Vendor: SEAGATE   Model: ST39102LCSUN9.0G  
Rev: 0828
Jan 14 15:49:37 ultra2 kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 02
Jan 14 15:49:37 ultra2 kernel: SCSI device sdc: 17689267 512-byte hdwr 
sectors (9057 MB)
Jan 14 15:49:37 ultra2 kernel: SCSI device sdc: drive cache: write through
Jan 14 15:49:37 ultra2 kernel:  sdc: sdc1 sdc3
Jan 14 15:49:37 ultra2 kernel: Attached scsi disk sdc at scsi2, channel 0, 
id 0, lun 0
<snip other disks attaching>
Jan 14 15:49:39 ultra2 kernel:   Vendor: SYMBIOS   Model: D1000             
Rev: 2
Jan 14 15:49:39 ultra2 kernel:   Type:   Processor                          
ANSI SCSI revision: 02
Jan 14 15:49:39 ultra2 kernel: scsi3 : PTI Qlogic,ISP SBUS SCSI irq 7,7db 
regs at 1ff30010000

but the box is completely dead (no Stop-A, no magic sysrq, no network 
activity) after this.

later,
chris
