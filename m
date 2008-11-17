From: Frans Pop <elendil@planet.nl>
Date: Mon, 17 Nov 2008 21:14:21 +0000
Subject: Re: [2.6.26.4] Oops: Unable to handle kernel paging request at virtual address 00000000491f2000
Message-Id: <200811172214.22063.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <200811152343.58603.elendil@planet.nl>
In-Reply-To: <200811152343.58603.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 17 November 2008, David Miller wrote:
> > We also collect info for a hardware summary at that point. It could
> > well be that one of the commands there caused it. ... And that does
> > indeed include a cat of /proc/iomem and /proc/ioports.
> >
> > Now for the difficult part: how do we find out which driver this was?
>
> Good question.  Perhaps you can find a way to make modprobe,
> insmod, and rmmod log something into the installation log?

I ran a small shell script with a loop that saved relevant data to files 
and included a 'cat /proc/io*' every 2 secs.

> > I'll see if I can reproduce while keeping a watch on loaded mods.
>
> Good luck, either way.

Unfortunately not. I was unable to reproduce the oops. I compared the 
sys/kernlog for both installs and they were mostly identical.
Only real difference was that the starting position of the target hard 
disk was different: the install that oopsed started with a partitioning 
using LVM (which was removed during the install), while the new install 
started out with the regular partitioning left over from that.

From the data of the old install I can tell that the culprit was
/proc/iomem (and not /proc/ioports). Contents of /proc/ioports and list of 
loaded modules at the end of the install are identical for both.

Module                  Size  Used by
dm_mod                 56776  0
md_mod                 84576  0
xfs                   483448  0
reiserfs              290816  0
jfs                   186992  0
ext3                  137872  2
jbd                    44200  1 ext3
vfat                   11520  0
fat                    51056  1 vfat
nls_base                9152  3 jfs,vfat,fat
ide_cd_mod             35528  0
cdrom                  38752  1 ide_cd_mod
ide_disk               13184  5
cmd64x                  6592  0 [permanent]
sunhme                 29744  0

So I guess I'll have one more go at it with the hard disk pre-partitioned 
with LVM. If that does not reproduce it, I guess we'll just have to leave 
this one to someone else to rediscover.

BTW, the system is a simple, old Ultra 10.

Cheers,
FJP
