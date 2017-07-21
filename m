From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 21 Jul 2017 02:49:57 +0000
Subject: Re: [PATCH 2/3] sparc64: 5-Level page table support for sparc
Message-Id: <7ef15017-e367-5f3e-fc8c-9e13a201c9da@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-2-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-2-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 7/20/2017 1:25 PM, David Miller wrote:
> From: Allen Pais <allen.pais@oracle.com>
> Date: Thu, 20 Jul 2017 13:10:36 +0530
>
>> From: Vijay Kumar <vijay.ac.kumar@oracle.com>
>>
>> Added 5-Level paging for sparc.
>>
>> Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
>> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> So for one chip, we're going to unconditonally eat an entire
> level of page table traversal on every PTE lookup?
>
> Either stick to what 4-level page tables support for M8 or
> make it run time selectable.
>
> Thanks.

I will look into it. Thanks for your input.

Thanks,
Vijay
