From: James Whatever <james@giantrobot.co.nz>
Date: Mon, 08 Mar 2004 18:26:26 +0000
Subject: Re: Losing my mind, RAID1 on Sparc completely broken?
Message-Id: <1C51EB1E-712E-11D8-8613-000A957DCC26@giantrobot.co.nz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The problem comes in when I make both disks a member of the same array.
> (in this case, hda2 and hdc2 are members of md1).  As soon as I sync 
> the
> array, I write to it, and it pretty much instantly corrupts.  
> Unmounting
> md1 and running a fsck on it shows a large number of illegal blocks.
> md5sums of various binaries on the system are wrong, apt and dpkg's
> status files get so horribly corrupted that they segfault or refuse to
> run.  All within minutes of even seconds of writing to md device.

This is opposite to the problem I have:

I have an SS20 with dual hypersparc 125MHz CPU's and dual 4.1GB SCA 
drives on an espfast controller inside the machine.

After getting to a point where I am happy with the Debian installation 
on a single disk I copied the partition data across to the second disk 
and started using the failed-disk method to copy data onto the raid.  I 
found that when copying quite a lot of data the kernel will oops, and I 
had to restart the process several times.  I did eventually find I was 
able to copy the ~1.5GB of install across without oopsing if I added 
the -u argument to cp (checks if the source file is newer than the 
target file) - it seems to me that the kernel was oopsing when writing 
constantly to the raid array, but was okay as long as it was read from 
quite a lot.

Anyway, I have succeeded in getting it all up and running with both 
disks in the array and using auto-detect to create the raidset at boot 
time and mounting it as root.  It seems to be working okay now, and I 
haven't noticed any data corruption on my ext3 partition.

I am using a home built Linux 2.4.25 kernel.

One thing is that SILO now only gets as far as S and then I get 
"Program terminated" - I'm not sure what's causing this, but now I have 
to do "boot cdrom /iommu/.....;1/vmlinuz root=/dev/md0 ro" to start my 
machine.  Anyone have any ideas about what's up with SILO?

I have the latest SILO from sarge installed.

Cheers.

---
James Whatever
My niece called me "Uncle Robot" on the weekend!
Giant Robot Ltd, http://www.giantrobot.co.nz/

