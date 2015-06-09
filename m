From: David Miller <davem@davemloft.net>
Date: Tue, 09 Jun 2015 07:46:41 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150609.004641.1323317951176412858.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 09 Jun 2015 00:34:14 -0700 (PDT)

> Your test is faulty.
> 
> You cannot use ASI_BLK_P loads or stores without appropriate memory
> barriers around them.
> 
> The rules for when and where you need the memory barriers are
> complicated, especially if you want to incur the cost of the memory
> barrier as infrequently as possible.

FWIW, you're probably hitting the bug fixed by the following commit in
glibc:

commit 834caf06f33d79be54cff63c274fba2845513593
Author: Jose E. Marchesi <jose.marchesi@oracle.com>
Date:   Sat May 17 11:20:27 2014 -0700

    Fix sparc memcpy data corruption when using niagara2 optimized routines.
    
        * sysdeps/sparc/sparc64/multiarch/memcpy-niagara2.S: Add missing
        membar to avoid block loads/stores to overlap previous stores.

