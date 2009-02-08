From: Matt Cole <mikaey@neb.rr.com>
Date: Sun, 08 Feb 2009 05:17:51 +0000
Subject: Re: SILO problems
Message-Id: <498E6AFF.6080205@neb.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Matt Cole <mikaey@neb.rr.com>
> Date: Sat, 07 Feb 2009 20:29:14 -0600
>
>   
>> David and Tom, one of the problems I've noticed is that, with having
>> the boot partition start on cylinder 0, that creating anything on
>> that partition results in overwriting the disklabel.  David, I
>> noticed your fdisk readout has your boot partition starting on
>> cylinder 0, is this just a dummy partition?  Or how did you get
>> around this problem?
>>     
>
> Most filesystems do not write their superblock into the initial
> bytes of the partition, they leave it alone.
>
> You can't put things like RAID and swap partitions there, because
> those will in fact zap out your boot block and disk label.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Well I'll be damned...so you're right.  But still no luck.  I'm 
wondering if there's a deeper problem...you'd think if it was a problem 
with the first stage loader trying to find the second stage loader, I'd 
at least see the "S" printed, but I get nothing.  It would appear it's 
trying to execute something, however, because if I do Stop+A and issue 
any sort of "boot" command, it reboots the machine.  You don't suppose 
any of it would have to do that I downloaded the pre-compiled loaders, 
instead of compiling them from source?  (I tried, the second stage 
loader won't compile on my machine for some reason)

Thanks,
Matt Cole
