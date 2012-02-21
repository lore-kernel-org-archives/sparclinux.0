From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Feb 2012 13:43:07 +0000
Subject: silo trouble with ext3
Message-Id: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Short summary: silo can not find any files from my ext3. Was this 
the problem recently discussed here about silo?

Debian unstable's silo 1.4.14+git20120127-1 and 110G ext3 filesystem. 
The same machine worked fine for years, running all the kernels and 
Debian unstable. Last successful reboot was less than a week ago, and 
Debian was updated after that (probably updating silo package).
Today I compiled 3.3-rc4+git and rebooted to try it, and silo can not 
find anything. silo itself loads but can not open neither /etc/silo.conf 
nor any kernel image by direct name:

Rebooting with command: boot                                          
Boot device: disk  File and args: 
SILO Version 1.4.14

Cannot find /etc/silo.conf (error: 4294967295)

Couldn't load /etc/silo.conf
No config file loaded, you can boot just from this command line
Type [prompath;]part/path_to_image [parameters] on the prompt
E.g. /iommu/sbus/espdma/esp/sd@3,0;4/vmlinux root=/dev/sda4
or 2/vmlinux.live (to load vmlinux.live from 2nd partition of boot disk)
boot: 1/boot/test
Allocated 64 Megs of memory at 0x40000000 for kernel

Cannot find /boot/test (error: 4294967295)

Image not found.... try again
boot:


Tried fsck.ext3 -f, did not help. Re-installed silo from netboot 
chroot, did not help either.

This is Ultra 5 with OBP 3.31 (latest available), so should not have any 
1G or 2G limits on boot partition?

Ideas?

-- 
Meelis Roos (mroos@linux.ee)
