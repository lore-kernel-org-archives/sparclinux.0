From: Bob Picco <bob.picco@oracle.com>
Date: Wed, 01 Feb 2017 12:38:20 +0000
Subject: [PATCH 0/3] tsb expansion for sun4v
Message-Id: <20170201123823.6273-1-bob.picco@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bob.picco@oracle.com>

Hi,

This patch series enables a tsb on recent sun4v cores to expand
beyond the current kmem cache limits used by tsb_grow(). A substantial
performance improvement has been observed for applications with a large
tsb rss demand.

There should be no performance impact to sun4u and not included sun4v
core types. There is potential to include other core types with minimal
effort.

The tsb size performance issue was analyzed substantially in early 2015.
The performance impact was very evident for the database and its supporting
software. A small mmap test program was constructed to illustrate the issue.

These performance numbers were collected by Stanislav(Stas) and Guru. 
Stas kindly wrote the report which received miniscule edit by me. Stas
generated some nice ods graphs which we would gladly share. Stas is the
author of the test_with_mmap.c program and this too is available upon request.
I have left the instructions for building and running test_with_mmap.c
should you decide to experiment and/or validate our numbers. For context
of collected values presented below, smaller is the more optimum. I
apologize for not providing a public link for ods file and C source file
but Oracle does not seem to have a convenient method for a developer.
The entire report is contained immediately after this paragraph.

The benefit from using the patches was evaluated by using the attached test
program - test_with_mmap.c

The program allocates memory using "ordinary" or "huge" pages, writes
some data to the memory, reads it, measures the time spent in reading/writing.
The memory is written/read with block granularity.

The program was built as:

gcc -Wall -m64 -o test_with_mmap test_with_mmap.c -lrt -lm

The goal was to examine the TSB, so the block size was chosen
to be the page size.

Command used in Linux:
./test_with_mmap -i 10 -b 8k -r $region_size

Command used in Solaris:
./test_with_mmap -i 10 -b 8k -p 8k -r $region_size

where
 -i - number of iterations to repeat the whole alloc/write/read/free
      cycle
 -b - the block size
 -p - the page size used to allocate the memory (Solaris only).
      On Linux the default page size (8k) is used.
 -r - the amount of memory to allocate

The above commands were executed with different values of $region_size,
with different hardware, and values from the "read_4" row (us) were saved
and put to the tables below.

Three OS instances were examined:
 * Linux v4.10-rc5-111-g49e555a with no patches applied ("no patch")
 * Linux v4.10-rc5-111-g49e555a with the patches applied ("patch")
 * the latest publicly available version of Solaris 11.3

Both the Linux kernels were built with CONFIG_FORCE_MAX_ZONEORDER
 
Solaris data was collected only to illustrate that we are not worse
than Solaris. It's better to avoid comparing absolute values between
Linux and Solaris, since different versions of gcc were used, and there
was no goal to get highly-accurate absolute numbers.

Repeating each scenario 10 times (-i 10) gave coefficients
of variation (CV) < 5% for all the presented data.

1. T7-2 LDOM. 4 vCPU, 32GB RAM

mmu-max-tsb-entries = 0x80000000

+-----------+--------+--------+--------+
|region_size|no patch| patch  | S11.3  |
+-----------+--------+--------+--------+
|256m       |  888.64|  885.33|  926.23|
+-----------+--------+--------+--------+
|320m       | 1096.16| 1097.02| 1151.21|
+-----------+--------+--------+--------+
|384m       | 1311.02| 1312.44| 1382.20|
+-----------+--------+--------+--------+
|448m       | 1534.28| 1533.70| 1617.01|
+-----------+--------+--------+--------+
|512m       | 1741.04| 1736.21| 1840.40|
+-----------+--------+--------+--------+
|576m       |10885.34| 1958.27| 2068.41|
+-----------+--------+--------+--------+
|640m       |20029.18| 2185.42| 2321.79|
+-----------+--------+--------+--------+
|704m       |29174.22| 2392.41| 2529.47|
+-----------+--------+--------+--------+
|768m       |38330.03| 2597.53| 2766.51|
+-----------+--------+--------+--------+
|2g         |        | 6996.52| 7324.10|
+-----------+--------+--------+--------+
|4g         |        |14179.75|15031.50|
+-----------+--------+--------+--------+
|6g         |        |22739.78|23393.57|
+-----------+--------+--------+--------+
|8g         |        |30532.06|32148.94|
+-----------+--------+--------+--------+
|10g        |        |38808.78|40430.79|
+-----------+--------+--------+--------+
|12g        |        |48192.40|50292.28|
+-----------+--------+--------+--------+
|14g        |        |63295.06|62081.07|
+-----------+--------+--------+--------+
|16g        |        |77528.53|76133.42|
+-----------+--------+--------+--------+

As designed, the patches come to play when the region > 512m with 8k pages,
i.e. when the TSB > 1m

2. T7-2 bare-metal machine. 256GB RAM

mmu-max-tsb-entries = 0x80000000

+-----------+--------+--------+--------+
|region size|no patch| patch  | S11.3  |
+-----------+--------+--------+--------+
|256m       |  896.42|  893.94| 1300.72|
+-----------+--------+--------+--------+
|320m       | 1077.53| 1113.77| 1628.67|
+-----------+--------+--------+--------+
|384m       | 1374.84| 1331.38| 1937.39|
+-----------+--------+--------+--------+
|448m       | 1512.21| 1547.06| 2293.58|
+-----------+--------+--------+--------+
|512m       | 1800.35| 1752.13| 2589.45|
+-----------+--------+--------+--------+
|576m       |10816.66| 1990.98| 2925.43|
+-----------+--------+--------+--------+
|640m       |19912.01| 2209.60| 3266.45|
+-----------+--------+--------+--------+
|704m       |29138.67| 2421.58| 3547.10|
+-----------+--------+--------+--------+
|768m       |38215.05| 2639.70| 3919.14|
+-----------+--------+--------+--------+
|2g         |        | 7002.06|10309.68|
+-----------+--------+--------+--------+
|4g         |        |14031.26|20800.67|
+-----------+--------+--------+--------+
|6g         |        |22737.31|32157.27|
+-----------+--------+--------+--------+
|8g         |        |30327.43|43313.26|
+-----------+--------+--------+--------+
|10g        |        |38166.01|54417.91|
+-----------+--------+--------+--------+
|12g        |        |45825.36|65615.88|
+-----------+--------+--------+--------+
|14g        |        |53745.17|75464.72|
+-----------+--------+--------+--------+
|16g        |        |61909.64|88794.12|
+-----------+--------+--------+--------+

Effect of the patches is similar to the T7-2 ldom case above.

3. T5-8 bare-metal machine. 2TB RAM

No mmu-max-tsb-entries

+-----------+--------+---------+---------+
|region size|no patch|  patch  |  S11.3  |
+-----------+--------+---------+---------+
|256m       | 1282.48|  1237.02|  1490.88|
+-----------+--------+---------+---------+
|320m       | 1582.04|  1402.70|  1862.87|
+-----------+--------+---------+---------+
|384m       | 1897.30|  1672.54|  2225.20|
+-----------+--------+---------+---------+
|448m       | 2200.42|  1968.63|  2590.34|
+-----------+--------+---------+---------+
|512m       | 2508.67|  2214.64|  2970.70|
+-----------+--------+---------+---------+
|576m       |12952.35|  2476.88|  3333.26|
+-----------+--------+---------+---------+
|640m       |23196.00|  2675.64|  3710.52|
+-----------+--------+---------+---------+
|704m       |33594.81|  3021.73|  4088.76|
+-----------+--------+---------+---------+
|768m       |44024.04|  3274.23|  4459.49|
+-----------+--------+---------+---------+
|2g         |        |  8744.85| 11856.14|
+-----------+--------+---------+---------+
|4g         |        | 18075.35| 25066.44|
+-----------+--------+---------+---------+
|6g         |        | 38238.04| 46081.15|
+-----------+--------+---------+---------+
|8g         |        | 51342.70| 62928.90|
+-----------+--------+---------+---------+
|10g        |        | 67445.53| 77680.87|
+-----------+--------+---------+---------+
|12g        |        | 80693.10| 93567.80|
+-----------+--------+---------+---------+
|14g        |        | 93587.64|108438.67|
+-----------+--------+---------+---------+
|16g        |        |108258.13|126455.04|
+-----------+--------+---------+---------+

Effect of the patches is similar to the previous two cases.

This machine had enough memory to perform equivalent test
cases but with 8M huge pages, so a set of tests using:

./test_with_mmap -i 10 -h -b 8m -r $region_size

was performed on that machine, and here are the results

+-----------+--------+-------+
|region size|no patch| patch |
+-----------+--------+-------+
|128g       |   730.9| 744.83|
+-----------+--------+-------+
|192g       | 1137.66|1122.72|
+-----------+--------+-------+
|256g       | 1517.06|1512.26|
+-----------+--------+-------+
|320g       |13486.47|1933.85|
+-----------+--------+-------+
|384g       |26406.62|2313.34|
+-----------+--------+-------+

As planned, the patches come to play when the TSB size > 1m, i.e. when
the region size is > 256g with 8 MB pages.

This concludes the report.

thanx,

bob

Cc: stanislav.kholmanskikh@oracle.com
Cc: gurudas.pai@oracle.com


bob picco (3):
  sparc64: make tsb pointer computation symbolic
  sparc64: tsb size expansion
  sparc64: increase FORCE_MAX_ZONEORDER to 16

 arch/sparc/Kconfig                 |   2 +-
 arch/sparc/include/asm/spitfire.h  |   5 +
 arch/sparc/kernel/sun4v_tlb_miss.S |  24 ++---
 arch/sparc/mm/tsb.c                | 201 ++++++++++++++++++++++++++-----------
 4 files changed, 161 insertions(+), 71 deletions(-)

-- 
2.11.0

