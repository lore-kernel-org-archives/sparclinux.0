From: Stefan Holst <mail@s-holst.de>
Date: Sun, 21 Mar 2004 15:50:52 +0000
Subject: srmmu_nocache_calcsize with low memory
Message-Id: <20040321155052.GA10374@spike>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hello,

there is a problem in 2.6.4/5 according the amount of system ram
reserved on machines with very low memory (e.g. leon systems ;)).

in void srmmu_nocache_calcsize(void) there is a hardcoded minimum size
for srmmu_nocache_npages of currently 550:

	srmmu_nocache_npages 		sysmemavail / SRMMU_NOCACHE_ALCRATIO / 1024 * 256;

 /* P3 XXX The 4x overuse: corroborated by /proc/meminfo. */
	// if (srmmu_nocache_npages < 256) srmmu_nocache_npages = 256;
	if (srmmu_nocache_npages < SRMMU_MIN_NOCACHE_PAGES)
		srmmu_nocache_npages = SRMMU_MIN_NOCACHE_PAGES;


i didn't really understand the comment - what is the matter with that?

after deactivating this minimum enforcement, my 4mb-system doesn't work
either; the calculated value (16) seems to be much too low. i did some
testing and found, that the system starts fine from a value around 27:

srmmu_nocache_npages = 27:

/ # cat proc/meminfo 
MemTotal:         2648 kB
MemFree:          1344 kB
Buffers:           396 kB
Cached:            380 kB
SwapCached:          0 kB
Active:            756 kB
Inactive:          148 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         2648 kB
LowFree:          1344 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            388 kB
Slab:              432 kB
Committed_AS:      252 kB
PageTables:         24 kB
VmallocTotal:    25600 kB
VmallocUsed:         0 kB
VmallocChunk:    25600 kB

with a value of 350, the system begins to run out of memory while
loading busybox (it gets very slow):

srmmu_nocache_npages = 350:

/ # cat proc/meminfo 
MemTotal:         1356 kB
MemFree:           344 kB
Buffers:           396 kB
Cached:             84 kB
SwapCached:          0 kB
Active:            516 kB
Inactive:          128 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         1356 kB
LowFree:           344 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            196 kB
Slab:              432 kB
Committed_AS:      252 kB
PageTables:         24 kB
VmallocTotal:    25600 kB
VmallocUsed:         0 kB
VmallocChunk:    25600 kB

srmmu_nocache_calcsize should be fixed for low memory. but how? any
suggestions?

-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
