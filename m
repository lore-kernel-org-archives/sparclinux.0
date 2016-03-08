From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 08 Mar 2016 14:56:15 +0000
Subject: Re: sparc64: Reduce TLB flushes on hugetlb PTE change
Message-Id: <56DEE80F.5000408@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1457403807-26555-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1457403807-26555-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 03/07/2016 08:32 PM, David Miller wrote:
> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> Date: Mon,  7 Mar 2016 18:23:27 -0800
>
>> Flush TSB and TLB only at REAL_HPAGE_SIZE boundaries and
>> not at every 8K stride.
>>
>> Orabug: 22643230
>>
>> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> Is this an update to your earlier patch?

No, this is a separate patch.

Nitin

> If so, why aren't you explaining what you have changed?
>
> Also, why haven't you put a proper version indication in
> the Subject line?  Like "v3" or something?
>
> By making more and more work for me like this, you are
> making it more difficult for me to process my backlog
> and get to actually reviewing the content of your change
> and integrating it.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

