From: James Y Knight <jyknight@google.com>
Date: Tue, 09 Jun 2015 12:13:58 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <ECF5D654-B024-4286-A22F-BF6CDF437D7F@google.com>
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

Um, but my test isn't testing what is being stored to memory at all. It is storing to memory and **never loading from the memory after**. Why would writing FROM fp registers TO memory corrupt the *registers* due to a missing memory barrier?

If problem 1 is due to a missing membar somewhere, I think it's surely gotta be the kernel that's missing it, not my test code. No?

> FWIW, you're probably hitting the bug fixed by the following commit in
> glibc:
> 
> commit 834caf06f33d79be54cff63c274fba2845513593
> Author: Jose E. Marchesi <jose.marchesi@oracle.com>
> Date:   Sat May 17 11:20:27 2014 -0700
> 
>    Fix sparc memcpy data corruption when using niagara2 optimized routines.
> 
>        * sysdeps/sparc/sparc64/multiarch/memcpy-niagara2.S: Add missing
>        membar to avoid block loads/stores to overlap previous stores.
> 

Debian glibc has multiarch support disabled (done a couple years ago to try to workaround the unreliability, not entirely successfully..), so it's not using that routine you mention. It's using sysdeps/sparc/sparc32/sparcv9/memcpy.S which points to sysdeps/sparc/sparc64/memcpy.S

[sorry for the duplicate post -- didn't realize vger.kernel.org doesn't accept emails sent by the android gmail client]