From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Jul 2017 08:16:46 +0000
Subject: Re: Spontaneous reboots seem to have been fixed - not
Message-Id: <alpine.LRH.2.20.1707071019470.605@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> >> I started at the same time on 2 machines and spread to third when I 
> >> copied the .config oveer to it, so at the moment I do not suspect the 
> >> hardware but the kernel.
> >>
> >> Will put more time to it but I do not know when.
> > 
> > I did it on dual-CPU v210.
> > 
> > Minimized config to minimal nonmodular working one. That worked stable 
> > with current 4.12-rc7+git. Then added THP and enabled it (always on) - 
> > trouble was back. Disabled THP, this left on some setting that THP 
> > enabled (compaction etc), it was working again.
> > 
> > So it is THP.
> > 
> > Attached are good and bad minimal configs for my V210.
> > 
> > What is the next thing I can do to debug it?
> > 
> 
> Thanks for the minimal config. I will try to reproduce this locally on
> the machines I have. Finding the bad commit would be a good first step.

I tried bisecting with THP on. First frame was that 4.5 was good and 4.6 
was bad. These results were repeatable.

Nex I found that 4.5.0-10882-g266c73b was the first bad one but found no 
other bad commits back to 4.5. That seemed strange so I retested 4.6 
(was still bad) and the same commit. Now I can not reproduce the badness 
with the same config any more - I have a repeating script for test that 
untars old git tree, does git pull on that, then builds it, and it has 
worked fine for many iterations now.

So my script for reproducing is not good enough it seems.

However, turing THP off has cured all the machines - V210, V240, V440, 
E420R - and compiling current git on them with 4.12 and THP off has 
worked with no problems.

-- 
Meelis Roos (mroos@linux.ee)
