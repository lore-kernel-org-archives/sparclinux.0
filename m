From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Wed, 12 Jul 2017 03:43:39 +0000
Subject: Re: sun4v+DMA related boot crash on 4.13-git
Message-Id: <94c3900e-781e-da0e-e1fe-ad1239ed8dee@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c6d6bb9f-23d7-4768-8759-f445665b1b6f@oracle.com>
 <alpine.LRH.2.20.1707120047250.9598@math.ut.ee>
 <60fa7a06-d319-9b6f-aba8-7b63014a1120@oracle.com>
 <20170711.173436.720922946430226024.davem@davemloft.net>
In-Reply-To: <20170711.173436.720922946430226024.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 07/11/2017 05:34 PM, David Miller wrote:
> From: Tushar Dave <tushar.n.dave@oracle.com>
> Date: Tue, 11 Jul 2017 15:38:21 -0700
> 
>>
>>
>> On 07/11/2017 02:48 PM, Meelis Roos wrote:
>>>>>>>> I tested yesterdayd 4.12+git on sparc64 to see if the sparc merge
>>>>>>>> works
>>>>>>>> fine, and on all of my sun4v machines (T1000, T2000, T5120) it crashed
>>>>>>>> on boot with DMA-related stacktrace (below). Allt he machines are
>>>>>>>> sun4v
>>>>>>>> physical machines, not VM-s. Older sun4 machines do not exhibit this
>>>>>>>> problem.
>>>>>>>>
>>>>>>>> Maybae DMA APi realted, maybe sparc64. Will try to bisect when I get
>>>>>>>> time.
>>>>>>> I see whats going on with panic. I will reproduce locally. Will get
>>>>>>> back
>>>>>>> soon.
>>>>>> This patch should fix panic. Please give it a try.
>>>>>
>>>>> Yes, this patch fixes it. Thank you for fixing it quickly!
>>>> Thanks for testing. Patch sent for sparc-next.
>>> Why sparc-next - it should go into 4.13 since 4.13 would break all
>>> niagara1 and niagara2 systems otherwise?This is sparc arch fix so I
>>> used sparc tree(in this case for sparc-next).
>> I am open to maintainers suggestions. Thanks.
> 
> If the bug is in Linus's tree the fix must target 'sparc' not
> 'sparc-next'.

Dave,

Yes, indeed the bug is in Linus's tree. However, 'sparc' tree doesn't 
have DMA API change (e.g. commit b02c2b0bfd7ae) yet that introduced the 
panic. Looks like the DMA API changes have not merged into 'sparc' tree 
yet. In other words, 'sparc' tree doesn't have mentioned panic issue, 
nothing to fix there!
However, 'sparc-next' is up to date (or more close to) linus tree and 
has DMA API change that cause mentioned panic issue. So I have send 
patch targeted for sparc-next.

Let me know what should be the best tree to get this fix in and I will 
send v2.

Thanks.

-Tushar
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
