From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 22 Jan 2012 11:02:00 +0000
Subject: Partitioning fails on a Sparc Ultra5 with Debian Lenny
Message-Id: <CAGRGNgWMC0W9NJ-u+NwkUTh7vXqhV1kO6_+ib94h-fzQTL176w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I am attempting to install Debian Linux on a Sparc Ultra5. For my own
convenience I'm using netboot over TFTP images to install this
machine, however I've been consistently running into problems
partitioning the disks I have available.

The issue is rather simple, whenever I attempt to partition any disk I
use with this machine (I've used disks with sizes between 5GB and
120GB - basically my entire stock of IDE drives) it fails with an
undescribed error after writing the partition table.

I initially started installing with Lenny, the oldest version I had
available as I had trouble installing Squeeze, (TFTPBoot images after
Lenny lack a driver for this particular chipset) so the symptoms
described below are for that particular version of Debian.

I took the "unknown" error to mean that there was some issue with the
default partitioner in Debian-installer (a modified parted, if I'm
reading the code correctly) so, after learning how Debian-installer
worked, downloaded the official udeb fdisk and attempted to partition
using that tool, and discovered that partition tables would not stay
written. Writing a SUN or MSDOS partition table would apparently write
without errors, but when I re-ran the tool, it complained that there
was no partition table on the disk. I then tried the same experiment
with parted and discovered that only a mac partition table would stay
written on the disk.

Over a year later, I discovered that mac partition tables are only a
couple of bytes, so I guessed that the error here was that the IDE
controller was too old to write to disks above 8.4GB (the old size
limit for PCs from the "olden" days) so I obtained a 5.1GB disk, and
today attempted installation again with the same results.

The most annoying thing about this is that I know that one of the
disks in my possession *did* work with this computer, however I
removed it as I needed it for another project and have since misplaced
it.

Debian Lenny uses a Debian enhanced version of the 2.6.26 kernel and
the IDE chipset is a CMD64x chip, (Config option:
CONFIG_BLK_DEV_CMD64X) I'm using generic IDE disks that work fine on
ordinary PCs or through USB => IDE boxes.

Can anyone help?

Please note that the install environment boots fine, and once it's
booted, the system works fine, from what I can tell, within the
install environment. As for the physical hardware, I'm using a
known-working 80 pin IDE cable, setting the disk to master and placing
it as the last drive on the cable.

Has anyone seen this happen before and how was it fixed?

Is there something specific that an Ultra5 looks for in a hdd?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
