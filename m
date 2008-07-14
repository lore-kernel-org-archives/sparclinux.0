From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 14 Jul 2008 21:26:38 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807141720350.30981@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080713.174119.71992292.davem@davemloft.net>
 <20080714111917S.fujita.tomonori@lab.ntt.co.jp> <20080713.202035.172246136.davem@davemloft.net>
 <20080715024424R.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20080715024424R.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Tue, 15 Jul 2008, FUJITA Tomonori wrote:

> On Sun, 13 Jul 2008 20:20:35 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
>
>> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
>> Date: Mon, 14 Jul 2008 11:19:02 +0900
>>
>>> Now IOMMUs don't ignore the max_segment_size. We hit this problem.
>>
>> It seems simply that max_segment_size needs to propagate
>> down into the block layer VMERGE code so that it can
>> act accordingly.
>
> Yeah, I think so. I'll take care of that.
>
> But I think that even with the fix, SPARC64 IOMMU still hits the
> problem.
>
> With the VMERGE accounting enabled,
>
> - an IOMMU must merge segments that the block layer expects the IOMMU
> to merge.
>
> - an IOMMU must return an error if it can't merge such segments.
>
> But the current SPARC64 IOMMU code doesn't return an error if it can't
> merge such segments (as POWER's IOMMU does, as you know).

BTW. what should the block device driver do when it receives a mapping 
error? (if it aborts the request and it was write request, there will be 
data corruption). Is it even legal to return IOMMU error in case where no 
real hardware error or overflow happened?

Mikulas
