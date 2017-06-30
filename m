From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 30 Jun 2017 05:36:27 +0000
Subject: Re: Spontaneous reboots seem to have been fixed - not
Message-Id: <61f9f28f-544b-f92a-54a8-5ad2d942dbd3@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 6/29/17 10:10 AM, Meelis Roos wrote:
>> I started at the same time on 2 machines and spread to third when I 
>> copied the .config oveer to it, so at the moment I do not suspect the 
>> hardware but the kernel.
>>
>> Will put more time to it but I do not know when.
> 
> I did it on dual-CPU v210.
> 
> Minimized config to minimal nonmodular working one. That worked stable 
> with current 4.12-rc7+git. Then added THP and enabled it (always on) - 
> trouble was back. Disabled THP, this left on some setting that THP 
> enabled (compaction etc), it was working again.
> 
> So it is THP.
> 
> Attached are good and bad minimal configs for my V210.
> 
> What is the next thing I can do to debug it?
> 

Thanks for the minimal config. I will try to reproduce this locally on
the machines I have. Finding the bad commit would be a good first step.

I'm on vacation till Jul 10, so would probably look in detail after that.

Nitin

