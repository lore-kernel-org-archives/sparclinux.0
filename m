From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 08 Jan 2016 21:15:32 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <20160108211532.GE3398@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (01/08/16 22:18), mroos@linux.ee wrote:
> 
> lsmod on v440:

my lsmod output is a superset of this list.

> > It could also be influenced by either the amount of memory he has
> > installed, or what userland he is using.
> 
> v240 has 6G RAM, v440 has 8G.

here's meminfo for my v440:

# cat /proc/meminfo
MemTotal:        4114000 kB
MemFree:         3456744 kB
MemAvailable:    4012144 kB
Buffers:           83464 kB
Cached:           414264 kB
SwapCached:            0 kB
Active:           457064 kB
Inactive:          74816 kB
Active(anon):      34256 kB
Inactive(anon):      240 kB
Active(file):     422808 kB
Inactive(file):    74576 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       1566328 kB
SwapFree:        1566328 kB
Dirty:              2808 kB
Writeback:             0 kB
AnonPages:         34176 kB
Mapped:            16272 kB
Shmem:               352 kB
Slab:             102320 kB
SReclaimable:      87920 kB
SUnreclaim:        14400 kB
KernelStack:        1664 kB
PageTables:         1064 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     3623328 kB
Committed_AS:      72432 kB
VmallocTotal:   3298530689024 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:         0 kB

> 
> Userland is Debian unstable, as it was as of July 25, 2015. gcc 4.9.3-2, 
> binutils 2.25-10.

maybe it's the gcc/binutils? I'm using something older:

# gcc --version
gcc (Debian 4.6.3-14) 4.6.3
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

My binutils is 2.22-8+deb7u2

the other difference is that (due to firewall/proxy headaches) I 
git-pull on a different machine and then rsync over that tree to
the v440. 

I did not see anything significantly different about the ps/interrupts
etc. I do not have irqbalance or ntpd on the v440, though.

--Sowmini
