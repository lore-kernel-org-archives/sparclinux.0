From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 21 May 2004 16:06:03 +0000
Subject: SCSI error with 2.6 kernels
Message-Id: <20040521160603.GA13462@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I'm seeing SCSI errors while running with a 2.6 kernel. Usually what
happens is a 'cvs update' or some other large disk activity trips things
up, and then the hard drives get remounted read-only, and the SCSI
system seems to go into an offline-mode. When this happens attempts to
read various log files or nearly any files on the disks fail, and trying
to run commands like 'shutdown -r now' fail as well. Rebooting the
system is the only way out of the bind, usually accomplished via the
'stop-a' and 'reset' commands.

Here's the dmesg output for my SS20 when booted under 2.4.26-smp. I
have not seen any errors while running under the 2.4 kernels, btw.

SCSI subsystem driver Revision: 1.00
esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC%000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST31200W SUN1.05  Rev: 8724
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: MAB3045S SUN4.2G  Rev: 1806
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-4101TASUNSLCD  Rev: 3424
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 2061108 512-byte hdwr sectors (1055 MB)
Partition check:
  sda: sda1 sda2 sda3
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
  sdb: sdb1

Are there known errors with SCSI in the 2.6 kernels? Any issues with the
particular drives I have installed? Sorry I don't have more info in the
post - last night the machine did this SCSI spazz attack while
compiling my latest cvs update of GCC, and all I saw this morning were
lots of messages about 'SCSI error'.

Thanks.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
