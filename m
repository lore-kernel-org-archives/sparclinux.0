From: Robert Reif <reif@earthlink.net>
Date: Sat, 23 May 2009 01:21:54 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <4A174FB2.2060809@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Josip Rodin wrote:
> You might want to do the generic initramfs debug steps like those
> described at http://wiki.debian.org/InitramfsDebug
>
>   
I tried the steps above and I don't see any issues.  All the
devices are in /dev, fstype returns the right info and
/proc/modules are the same.

The two significant differences in boot messages are the
timestamps and the premount output of the bad boot
has less output.

good:

Begin: Running /scripts/init-premount ...
[42949392.740000] Driver 'sd' needs updating - please use bus_type methods
[42949392.770000] sd 1:0:0:0: [sda] 17689267 512-byte hardware sectors: 
(9.05 GB/8.43 GiB)
[42949392.790000] sd 1:0:0:0: [sda] Write Protect is off
[42949392.800000] sd 1:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, supports DPO and FUA
[42949392.820000] sd 1:0:0:0: [sda] 17689267 512-byte hardware sectors: 
(9.05 GB/8.43 GiB)
[42949392.830000] sd 1:0:0:0: [sda] Write Protect is off
[42949392.850000] sd 1:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, supports DPO and FUA
[42949392.860000]  sda: sda1 sda2 sda3 sda4
[42949392.920000] sd 1:0:0:0: [sda] Attached SCSI disk
Done.

bad:

Begin: Running /scripts/init-premount ...
[   16.080000] Driver 'sd' needs updating - please use bus_type methods
[   16.110000] sd 1:0:0:0: [sda] 17689267 512-byte hardware sectors: 
(9.05 GB/8.43 GiB)
[   16.120000] sd 1:0:0:0: [sda] Write Protect is off
[   16.130000] sd 1:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, supports DPO and FUA
[   16.150000]  sda: sda1 sda2 sda3 sda4
[   16.200000] sd 1:0:0:0: [sda] Attached SCSI disk
Done.


