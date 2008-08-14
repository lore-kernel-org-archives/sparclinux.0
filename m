From: David Miller <davem@davemloft.net>
Date: Thu, 14 Aug 2008 08:39:16 +0000
Subject: ultra5/10 bootup hang bug
Message-Id: <20080814.013916.193700865.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hey guys, while snooping around some more trying to figure out
what might be causing the MIGRATE_* value corruption and thus
the crash, I found the following bug.

In nid_range(), we can overshoot "end" if "start" begins on a
non-page boundary.

It may or may not fix the bug we're tracking down, I don't know,
but it's worth testing :-)  Anyways, the patch is below.

I also look forward to the tracing results from that debugging
patch I gave you guys earlier.

Thanks.

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 217de3e..6172951 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -796,6 +796,9 @@ static unsigned long nid_range(unsigned long start, unsigned long end,
 		start += PAGE_SIZE;
 	}
 
+	if (start > end)
+		start = end;
+
 	return start;
 }
 #else
