From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 29 Oct 2004 23:03:47 +0000
Subject: flush_dcache_page()/flush_icache_page() for larger page sizes
Message-Id: <20041029230347.GK12934@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm trying to figure out how to implement analogues of flush_icache_page()
and flush_dcache_page() for larger pagesizes (or otherwise determine if
I need to at all) on UltraSPARC, and am having trouble tracking down
the relevant documentation. If someone could name some relevant
document(s), I'd be much obliged.

Thanks.


-- wli

P.S.: I'm also looking for similar information about Super-H and its
64-bit analogue, but I'm not even sure what mailing list to look for.
