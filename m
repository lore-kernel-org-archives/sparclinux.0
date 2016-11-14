From: David Miller <davem@davemloft.net>
Date: Mon, 14 Nov 2016 18:40:59 +0000
Subject: Re: [PATCH] sparc64: fix compile warning section mismatch in find_node()
Message-Id: <20161114.134059.682882522756181183.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1478911260-108261-1-git-send-email-thomas.tai@oracle.com>
In-Reply-To: <1478911260-108261-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Thomas Tai <thomas.tai@oracle.com>
Date: Fri, 11 Nov 2016 16:41:00 -0800

> A compile warning is introduced by a commit to fix the find_node().
> This patch fix the compile warning by moving find_node() into __init
> section. Because find_node() is only used by memblock_nid_range() which
> is only used by a __init add_node_ranges(). find_node() and
> memblock_nid_range() should also be inside __init section.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>

Applied, thank you.
