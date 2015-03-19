From: David Miller <davem@davemloft.net>
Date: Thu, 19 Mar 2015 02:25:17 +0000
Subject: Generic IOMMU pooled allocator
Message-Id: <20150318.222517.1444725543017433108.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, paulus@samba.org, sowmini.varadhan@oracle.com


PowerPC folks, we're trying to kill the locking contention in our
IOMMU allocators and noticed that you guys have a nice solution to
this in your IOMMU code.

Sowmini put together a patch series that tries to extract out the
generic parts of your code and place it in lib/iommu-common.c so
that both Sparc and PowerPC can make use of it.

The real test is if powerpc can be converted to use it.

So if you guys could please take a look at the current version of
this series at:

http://patchwork.ozlabs.org/patch/449712/
http://patchwork.ozlabs.org/patch/449713/
http://patchwork.ozlabs.org/patch/449715/

and give us some feedback that would be great.

After we sort out making this work properly for both architectures we
can figure out who merges which parts via what tree(s).

Thanks!
