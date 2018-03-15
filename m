From: David Miller <davem@davemloft.net>
Date: Thu, 15 Mar 2018 19:28:15 +0000
Subject: sparc64 MM regression...
Message-Id: <20180315.152815.1012910593389921933.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


So I bisected a userspace corruption regression down to commit:

commit a8e654f01cb725d0bfd741ebca1bf4c9337969cc                                                                                    
Author: Nitin Gupta <nitin.m.gupta@oracle.com>                                                                                     
Date:   Wed Jan 31 16:18:09 2018 -0800                                                                                             
                                                                                                                                   
    sparc64: update pmdp_invalidate() to return old pmd value                                                                      

The transformation is basically from a set_pte_at() call into
an atomic cmpxchg64() loop to set the pmd.

The problem is that set_pmd_at() does more than just assign
the pmd entry.

It also does some accounting and also queues up a batch TLB
flush entry.

So the side effect of this change is that the TLB is never
flushed for these changed PMDs, and thus the userland memory
corruption I was seeing.
