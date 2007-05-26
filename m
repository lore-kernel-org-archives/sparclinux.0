From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 26 May 2007 14:57:53 +0000
Subject: Linux always starts with 9600 8N1
Message-Id: <Pine.LNX.4.61.0705261649590.7344@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I have set the OBP to run at 115200, also set agetty on ttyS0 to do the 
same, and also added console=ttyS0,115200 to silo.conf (and also tried 
console=ttyS0,115200n8). But! Linux still gives me 9600 8N1. The ominous 
double screen blanking (why is that done anyway?) already takes place 
with 9600. I smell a bug. What do you think?


Sun (TM) Enterprise 250 (2 X UltraSPARC-II 400MHz), No Keyboard                 
OpenBoot 3.30, 2048 MB memory installed, Serial #15119878.                      
Ethernet address 8:0:20:e6:b6:6, Host ID: 80e6b606.                             

Rebooting with command: boot                                          
Boot device: disk0  File and args: 
SWarning: Power Supply 0 Failure Indication
ILO Version 1.4.13
boot: 
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.21
Loading initial ramdisk (4027821 bytes at 0xC00000 phys, 0x40C00000 virt)...
\
Remapping the kernel... done.
Booting Linux...

<prints nothing because minicom is set to 115200, but receives 9600>

Aurora SPARC Linux release 2.99 (Angel)
Kernel 2.6.21-1.3149.al3.2smp on an sparc64

sun login: 




	Jan
-- 
