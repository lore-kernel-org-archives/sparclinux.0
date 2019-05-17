From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Fri, 17 May 2019 21:01:22 +0000
Subject: [PATCH 0/1] Fix for VM_FLUSH_RESET_PERMS on sparc
Message-Id: <20190517210123.5702-1-rick.p.edgecombe@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: dave.hansen@intel.com, namit@vmware.com, Rick Edgecombe <rick.p.edgecombe@intel.com>

Meelis Roos reported issues with the new VM_FLUSH_RESET_PERMS flag on the sparc
architecture. When freeing many BPF JITs simultaneously, the vfree flush
operations can become stuck waiting as they each try to vm_unmap_aliases().

It also came up that using this flag is not needed for architectures like sparc
that already have normal kernel memory as executable. This patch fixes the usage
of this flag on sparc to also fix it in case the root cause is also an issue on
other architectures. Separately we can disable usage of VM_FLUSH_RESET_PERMS for
these architectures if desired.

Rick Edgecombe (1):
  vmalloc: Fix issues with flush flag

 mm/vmalloc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.17.1
