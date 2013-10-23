From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Wed, 23 Oct 2013 01:18:18 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <526723DA.20509@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10/09/2013 12:18 PM, David Miller wrote:
> From: Gurudas Pai <gurudas.pai@oracle.com>
> Date: Thu, 03 Oct 2013 19:07:11 -0700
>
>> And run echo 1000000 > /proc/sys/vm/nr_hugepages couple of
>> times.
> You're running the machine out of memory and stressing the
> setup path of the hugepage subsystem a lot.
>
> This looks entirely different from the other crash/lockup,
> in that there it looked like a cpu died with interrupts
> disabled and thus wasn't responding even to cross calls.
>
> This really isn't in a format I can look into, sorry.
Following change fixes the issue for me, (this was removed by
759496ba6407c6994d6a5ce3a5e74937d7816208), not very sure how.

diff -Nrup arch/sparc/mm/fault_64.c /tmp/fault_64.c
--- arch/sparc/mm/fault_64.c    2013-10-22 20:10:04.302411223 -0400
+++ /tmp/fault_64.c    2013-10-22 20:10:19.593410899 -0400
@@ -427,6 +427,7 @@ good_area:
              goto bad_area;
      }

+    flags |= ((fault_code & FAULT_CODE_WRITE) ? FAULT_FLAG_WRITE : 0);
      fault = handle_mm_fault(mm, vma, address, flags);

      if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))


Thanks,
-Guru



