From: Babu Moger <babu.moger@oracle.com>
Date: Sat, 12 Aug 2017 00:25:48 +0000
Subject: Re: [PATCH v2 0/4] Update memcpy, memset etc. for M7/M8 architectures
Message-Id: <5aeffd85-7c41-0f91-54dd-d7432b274280@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502149972-61517-1-git-send-email-babu.moger@oracle.com>
 <20170810.143835.350138228946748074.davem@davemloft.net>
In-Reply-To: <20170810.143835.350138228946748074.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David,  Thanks for applying.

On 8/10/2017 4:38 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Mon,  7 Aug 2017 17:52:48 -0600
>
>> This series of patches updates the memcpy, memset, copy_to_user,
>> copy_from_user etc for SPARC M7/M8 architecture.
> This doesn't build, you cannot assume the existence of "%ncc", it is a
> recent addition.
>
> Furthermore there is no need to ever use %ncc in v9 targetted code
> anyways.
>
> I'll fix that up, but this was a really disappointing build failure
> to hit.
Thank you..
>
> Meanwhile, two questions:
>
> 1) Is this also faster on T4 as well?  If it is, we can just get rid
>     of the T4 routines and use this on those chips as well.

At the time of this work, our focus was mostly on T7 and T8. We did not 
test this code on T4.
For T4 and other older configs we used NG4 versions. I would think it 
would require some
changes to make it work on T4.

> 2) There has been a lot of discussion and consideration put into how
>     a memcpy/memset routine might be really great for the local cpu
>     but overall pessimize performance for other cpus either locally
>     on the same core (contention for physical resources such as
>     ports to the store buffer and/or L3 cache) or on other cores.
>
>     Has any such study been done into these issues wrt. this new code?
No, we have not done this kind of study.

