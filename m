From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Mar 2005 12:58:06 +0000
Subject: 16201MB HIGHMEM in 2.4.30-pre3
Message-Id: <Pine.SOC.4.61.0503231456330.5000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is 2.4.30-pre3 on Sparcstation-20 with 256M RAM (4x64M).

dmesg tells
16201MB HIGHMEM available.
On node 0 totalpages: 64854
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 16201 pages.

Looks like it confuses pages and megabytes?

-- 
Meelis Roos (mroos@linux.ee)
