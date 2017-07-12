From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jul 2017 00:34:36 +0000
Subject: Re: sun4v+DMA related boot crash on 4.13-git
Message-Id: <20170711.173436.720922946430226024.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <c6d6bb9f-23d7-4768-8759-f445665b1b6f@oracle.com>
        <alpine.LRH.2.20.1707120047250.9598@math.ut.ee>
        <60fa7a06-d319-9b6f-aba8-7b63014a1120@oracle.com>
In-Reply-To: <60fa7a06-d319-9b6f-aba8-7b63014a1120@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.n.dave@oracle.com
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Tue, 11 Jul 2017 15:38:21 -0700

> 
> 
> On 07/11/2017 02:48 PM, Meelis Roos wrote:
>>>>>>> I tested yesterdayd 4.12+git on sparc64 to see if the sparc merge
>>>>>>> works
>>>>>>> fine, and on all of my sun4v machines (T1000, T2000, T5120) it crashed
>>>>>>> on boot with DMA-related stacktrace (below). Allt he machines are
>>>>>>> sun4v
>>>>>>> physical machines, not VM-s. Older sun4 machines do not exhibit this
>>>>>>> problem.
>>>>>>>
>>>>>>> Maybae DMA APi realted, maybe sparc64. Will try to bisect when I get
>>>>>>> time.
>>>>>> I see whats going on with panic. I will reproduce locally. Will get
>>>>>> back
>>>>>> soon.
>>>>> This patch should fix panic. Please give it a try.
>>>>
>>>> Yes, this patch fixes it. Thank you for fixing it quickly!
>>> Thanks for testing. Patch sent for sparc-next.
>> Why sparc-next - it should go into 4.13 since 4.13 would break all
>> niagara1 and niagara2 systems otherwise?This is sparc arch fix so I
>> used sparc tree(in this case for sparc-next).
> I am open to maintainers suggestions. Thanks.

If the bug is in Linus's tree the fix must target 'sparc' not
'sparc-next'.
