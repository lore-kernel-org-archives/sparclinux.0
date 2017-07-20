From: jane.chu@oracle.com
Date: Thu, 20 Jul 2017 23:55:30 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <e53adff3-0ef6-806e-7aa6-5a9a56dd17b9@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 07/20/2017 04:50 PM, David Miller wrote:

> From: jane.chu@oracle.com
> Date: Thu, 20 Jul 2017 16:42:18 -0700
>
>> While I get a map-unmap test ready to run, I noticed the "rcu_sched
>> kthread starved"
> I get that with the current tree, it's not due to my patch.
Okay.

>
>> I'm not sure how your patch could have anything to do with it,
> It doesn't.
>
> Ignore the warnings, it happens on my system even when it's idle.
>
> Can you post your map-unmap test?  Maybe we can add it under
> tools/testing/selftests/ in the kernel tree.
>
I'm working on it at the moment.  When I get it in a reasonable shape, 
will post it.

thanks,
-jane

