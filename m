From: Meelis Roos <mroos@linux.ee>
Date: Mon, 15 Feb 2016 05:54:57 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <alpine.LRH.2.20.1602150751180.29662@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > It's getting more strange. I ran 4.4-rc8-00005 for 2-3 weeks nonstop, 
> > doing git clone and make -j4 in a loop, on both V240 and V440. Worked 
> > 100% stable.
> > 
> > Then I git git pull from kernel.org, tried to compile 4.5-rc1 (or was it 
> > rc2 already), on the same running 4.4.0-rc8-00005 and it rebooted, on 
> > both V240 and V440.
> 
> sorry for not getting back sooner - was on the road, and will be
> mostly offline again next week. But the symptoms sound like there 
> might be a memory and/or compiler issue. I'm not sure how to check this
> theory out.. maybe someone else with more expertise in this space
> can check?

Hmm, probability-wise that is not very likely that at least 4 different 
machines (V240, V440, E450, V100) grow a hardware error at 4.3 timeframe 
and start rebooting spontaneously?

Maybe something with our memory detection / bootmeme / memory ranges has 
changed?

Il will try more to find a way to reproduce the problem. Maybe putting 
aside an old git tree state (how do I get one?), then at each boot copy 
it and pull it and then compile.

-- 
Meelis Roos (mroos@linux.ee)
