From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Wed, 04 Apr 2012 14:41:28 +0000
Subject: Re: [PATCH 20/20 v4] sparc/mm/fault_64.c: Port OOM changes to do_sparc64_fault
Message-Id: <CAFPAmTRpB2hzW6=yfX38MkPteb=9ZuNx2k5YL-nF0e+jL8T6uQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1332780049-2777-1-git-send-email-consul.kautuk@gmail.com>
	<20120326.173614.1619139899994626442.davem@davemloft.net>
In-Reply-To: <20120326.173614.1619139899994626442.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 27, 2012 at 3:06 AM, David Miller <davem@davemloft.net> wrote:
> From: Kautuk Consul <consul.kautuk@gmail.com>
> Date: Mon, 26 Mar 2012 12:40:49 -0400
>
>> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
>> (mm: retry page fault when blocking on disk transfer) and
>> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
>> (x86,mm: make pagefault killable)
>>
>> The above commits introduced changes into the x86 pagefault handler
>> for making the page fault handler retryable as well as killable.
>>
>> These changes reduce the mmap_sem hold time, which is crucial
>> during OOM killer invocation.
>>
>> Port these changes to 64-bit sparc.
>>
>> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
>
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks David.

Since one or two of my other patches are being taken by the other arch
owners in their branches,
can you take this patch and apply it to your branch also ?

Much obliged if you do !
