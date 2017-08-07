From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 07 Aug 2017 23:52:48 +0000
Subject: [PATCH v2 0/4] Update memcpy, memset etc. for M7/M8 architectures
Message-Id: <1502149972-61517-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@oracle.com

This series of patches updates the memcpy, memset, copy_to_user, copy_from_user
etc for SPARC M7/M8 architecture.

New algorithm here takes advantage of the M7/M8 block init store ASIs, with much
more optimized way to improve the performance. More detail are in code comments.

Tested and compared the latency measured in ticks(NG4memcpy vs new M7memcpy).

1. Memset numbers(Aligned memset)

No.of bytes   NG4memset	   M7memset    	Delta ((B-A)/A)*100
	     (Avg.Ticks A) (Avg.Ticks B) (latency reduction)
  3		77		25		-67.53
  7		43		33		-23.25
  32		72		68		 -5.55
  128		164		44		-73.17
  256		335		68		-79.70
  512		511		220		-56.94
  1024		1552		627		-59.60
  2048		3515		1322		-62.38
  4096		6303		2472		-60.78
  8192		13118		4867		-62.89
  16384		26206		10371		-60.42
  32768		52501		18569		-64.63
  65536		100219		35899		-64.17


2. Memcpy numbers(Aligned memcpy)

No.of bytes   NG4memcpy	   M7memcpy    	Delta ((B-A)/A)*100
	     (Avg.Ticks A) (Avg.Ticks B) (latency reduction)
  3		20		19		-5
  7		29		27		-6.89
  32		30		28		-6.66
  128		89		69		-22.47
  256		142		143		 0.70
  512		341		283		-17.00
  1024		1588		655		-58.75
  2048		3553		1357		-61.80
  4096		7218		2590		-64.11
  8192		13701		5231		-61.82
  16384		28304		10716		-62.13
  32768		56516		22995		-59.31
  65536		115443		50840		-55.96

3. Memset numbers(un-aligned memset)

No.of bytes   NG4memset	   M7memset    	Delta ((B-A)/A)*100
	     (Avg.Ticks A) (Avg.Ticks B) (latency reduction)
  3		40		31		-22.5
  7		52		29		-44.2307692308
  32		89		86		-3.3707865169
  128		201		74		-63.184079602
  256		340		154		-54.7058823529
  512		961		335		-65.1404786681
  1024		1799		686		-61.8677042802
  2048		3575		1260		-64.7552447552
  4096		6560		2627		-59.9542682927
  8192		13161		6018		-54.273991338
  16384		26465		10439		-60.5554505951
  32768		52119		18649		-64.2184232238
  65536		101593		35724		-64.8361599717

4. Memcpy numbers(un-aligned memcpy)

No.of bytes   NG4memcpy	   M7memcpy    	Delta ((B-A)/A)*100
	     (Avg.Ticks A) (Avg.Ticks B) (latency reduction)
  3		26		19		-26.9230769231
  7		48		45		-6.25
  32		52		49		-5.7692307692
  128		284		334		17.6056338028
  256		430		482		12.0930232558
  512		646		690		6.8111455108
  1024		1051		1016		-3.3301617507
  2048		1787		1818		1.7347509793
  4096		3309		3376		2.0247809006
  8192		8151		7444		-8.673782358
  16384		34222		34556		0.9759803635
  32768		87851		95044		8.1877269468
  65536		158331		159572		0.7838010244

There is not much difference in numbers with Un-aligned copies
between NG4memcpy and M7memcpy because they both mostly use the
same algorithems.

v2:
 1. Fixed indentation issues found by David Miller
 2. Used ENTRY and ENDPROC for the labels in M7patch.S as suggested by David Miller
 3. Now M8 also will use M7memcpy. Also tested on M8 config.
 4. These patches are created on top of below M8 patches
    https://patchwork.ozlabs.org/patch/792661/
    https://patchwork.ozlabs.org/patch/792662/
    However, I did not see these patches in sparc-next tree. It may be in queue now.
    It is possible these patches might cause some build problems. It will resolve 
    once all M8 patches are in sparc-next tree.

v0: Initial version

Babu Moger (4):
  arch/sparc: Separate the exception handlers from NG4memcpy
  arch/sparc: Rename exception handlers
  arch/sparc: Optimized memcpy, memset, copy_to_user, copy_from_user
    for M7/M8
  arch/sparc: Add accurate exception reporting in M7memcpy

 arch/sparc/kernel/head_64.S       |   16 +-
 arch/sparc/lib/M7copy_from_user.S |   40 ++
 arch/sparc/lib/M7copy_to_user.S   |   51 ++
 arch/sparc/lib/M7memcpy.S         |  923 +++++++++++++++++++++++++++++++++++++
 arch/sparc/lib/M7memset.S         |  352 ++++++++++++++
 arch/sparc/lib/M7patch.S          |   51 ++
 arch/sparc/lib/Makefile           |    5 +
 arch/sparc/lib/Memcpy_utils.S     |  345 ++++++++++++++
 arch/sparc/lib/NG4memcpy.S        |  277 +++---------
 9 files changed, 1845 insertions(+), 215 deletions(-)
 create mode 100644 arch/sparc/lib/M7copy_from_user.S
 create mode 100644 arch/sparc/lib/M7copy_to_user.S
 create mode 100644 arch/sparc/lib/M7memcpy.S
 create mode 100644 arch/sparc/lib/M7memset.S
 create mode 100644 arch/sparc/lib/M7patch.S
 create mode 100644 arch/sparc/lib/Memcpy_utils.S

