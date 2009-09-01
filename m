From: Tejun Heo <tj@kernel.org>
Date: Tue, 01 Sep 2009 07:30:26 +0000
Subject: Re: boot panic after oops from sysfs_new_dirent
Message-Id: <4A9CCD92.4090909@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0908311646150.20934@math.ut.ee> <20090831.142215.111904849.davem@davemloft.net> <Pine.SOC.4.64.0909011003460.10184@math.ut.ee> <4A9CC9E9.2070609@kernel.org>
In-Reply-To: <4A9CC9E9.2070609@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Meelis Roos wrote:
>>>> I powered on my 6-CPU E3000 after a summer pause and tried todays 
>>>> 2.6.31-rc8+git on it. It fails - first it spills lots of warnings about 
>>>> percpu things, then oopses in sysfs_new_dirent and then panics.
>> Bisecting shows that there may be different crashes, like in
>> 56513ed50cc8a5c184a3f347e81d74c850cc14fa below:
> 
> Yeah, I was trying to fix that one with
> 74d46d6b2d23d44d72c37df4c6a5d2e782f7b088 and it seemingly fixed it on
> my machine.  Apparently broken on yours.  Are the errors different
> before and after 74d46d6b2d?

Ummm.... one more question.  Is cpu0 missing?  Can you please post the
output of "cat /proc/cpuinfo"?

Thanks.

-- 
tejun
