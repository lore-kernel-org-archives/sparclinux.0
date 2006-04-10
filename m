From: Jim Gifford <maillist@jg555.com>
Date: Mon, 10 Apr 2006 22:48:26 +0000
Subject: More on the Sun Disk Label Issue
Message-Id: <443AE0BA.8070706@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

My team has determined the cause of the issue is GCC 4.1, when 
util-linux and the kernel is compiled with GCC 4.1, the checksums go out 
of whack. We haven't haven't been able to isolate it down any further. 
Here's what we know so far.

If we compile a Kernel(2.6.12-2.6.15) or util-linux(2.12r, 2.13-pre7) with GCC 4.1 we get
this message during boot-up.
sda:Dev sda Sun disklabel: Csum bad, label corrupted
unknown partition table

If we run fdisk on the machine if booted via a netboot, and attempt to fix the issue. The
following error occurs.

"Device contains neither a valid DOS partition table, nor Sun, SGI or
OSF disklabel
Building a new sun disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable."

Then I configured the label and saved, then I got the following error
message.

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
sda:Dev sda Sun disklabel: Csum bad, label corrupted
unknown partition table
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
sda:Dev sda Sun disklabel: Csum bad, label corrupted
unknown partition table
Syncing disks.


I've tested using parted to create the label and the issues seems to 
work for the current session. Investigating this currently.
