From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 22 May 2017 21:57:39 +0000
Subject: Re: [PATCH v2 1/7] kernel/locking: Fix compile error with qrwlock.c
Message-Id: <9cf41ab6-0aea-4c63-9577-65a06f661312@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
 <1495239421-441642-2-git-send-email-babu.moger@oracle.com>
 <20170522.150328.1597262115447284483.davem@davemloft.net>
In-Reply-To: <20170522.150328.1597262115447284483.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


On 5/22/2017 2:03 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Fri, 19 May 2017 18:16:55 -0600
>
>> Some architectures use the following guard in include file
>>   "asm/spinlock_types.h" to discourage including the file directly.
>>
>> Saw these compile errors on SPARC when queued rwlock feature is enabled.
>>
>>    CC      kernel/locking/qrwlock.o
>> In file included from ./include/asm-generic/qrwlock_types.h:5,
>>                   from ./arch/sparc/include/asm/qrwlock.h:4,
>>                   from kernel/locking/qrwlock.c:24:
>> ./arch/sparc/include/asm/spinlock_types.h:5:3: error:
>>          #error "please don't include this file directly"
>>
>> Re-arrange the includes in qrwlock_types.h and include spinlock.h
>> in qrwlock.c to fix it.
>>
>> Also will be removing this stanza from SPARC. Stay tuned.
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
>> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> In my feedback I said to remove that check from
> sparc's asm/spinlock_types.h header.
>
> Which you do in patch #2
>
> But that means this patch #1 here is no longer necessary, since we
> conform to the hearder scheme used by other architectures using queued
> locks.
>
> So please remove this patch from the series.
Sorry. I did not make it clear. Patch #2 addresses this following problem.

./arch/sparc/include/asm/spinlock_types.h:5:3: error:
#error "please don't include this file directly"

But we still have this following problem. So we needed part of the patch #1.

   CC      kernel/locking/qrwlock.o
kernel/locking/qrwlock.c: In function ‘queued_read_lock_slowpath’:
kernel/locking/qrwlock.c:89: error: implicit declaration of function 
‘arch_spin_lock’
kernel/locking/qrwlock.c:102: error: implicit declaration of function 
‘arch_spin_unlock’
make[4]: *** [kernel/locking/qrwlock.o] Error 1

To address this we need following change.
======================
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0c..2655f26 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -20,6 +20,7 @@
  #include <linux/cpumask.h>
  #include <linux/percpu.h>
  #include <linux/hardirq.h>
+#include <linux/spinlock.h>
  #include <asm/qrwlock.h>

  /*
I will update the patch set with the above information. Does that work?

> Thank you.

