From: David Dillow <dave@thedillows.org>
Date: Mon, 09 Feb 2004 05:55:54 +0000
Subject: Increasing max size of sbus_map{single,sg}()?
Message-Id: <1076306154.3086.41.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've been working on a device driver that needs to map 3MB of user
memory into a contiguous DMA mapping on sparc64. The HW is pretty dumb,
which is why I cannot give it a scatter-list.

This works well, up to mappings of 1MB in size. This is not unexpected,
given the comment about NCLUSTERS in arch/sparc64/kernel/sbus.c. For
testing my driver, I've increased NCLUSTERS to 16, which works, but I
wouldn't ask for it to change in a production kernel -- it would
increase pressure on smaller allocations, and waste mapping space in the
upper clusters. Not good.

However, I looked at alloc_streaming_cluster() and
free_streaming_cluster() while trying to find a better solution. I
noticed that when it is calculating the cluster to use for the
allocation/freeing, it never checks cnum against NCLUSTERS, and so
passing a request size larger than 1MB will potentially corrupt memory
-- at the very least we'll read from areas that we shouldn't.

I thought it may be possible to clamp cnum in those functions to the
last cluster, but I see it will take some changes in the search
algorithm, which I am not sure is a great idea.

Would such a change stand any chance of being merged? Is there a better
way?

Thanks for any insight,
Dave


