From: Meelis Roos <mroos@linux.ee>
Date: Fri, 05 Feb 2016 09:06:47 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <alpine.LRH.2.20.1602051103140.5582@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > On (01/07/16 21:46), Meelis Roos wrote:
> > > So far I have made sure that 4.2.0 works fine on V240 overnight with the 
> > > following command to find any other errors too.
> > > while true; do make clean; make -j2 || break; done
> > 
> > let me restart a loop with your .config on my v440 and let this run
> > overnight, to see if I can reproduce your case.
> 
> Hmm. I've rebooted my v440 with a kernel built with your .config,
> I've been able to do the above make loop for several hours now. 

It's getting more strange. I ran 4.4-rc8-00005 for 2-3 weeks nonstop, 
doing git clone and make -j4 in a loop, on both V240 and V440. Worked 
100% stable.

Then I git git pull from kernel.org, tried to compile 4.5-rc1 (or was it 
rc2 already), on the same running 4.4.0-rc8-00005 and it rebooted, on 
both V240 and V440.

I also saw a spontaneous reboot on E450 with 4.4.0-rc5-00008. Did not 
try continuous building on E450.

I'm quite stumped in trying to reproduce that...

-- 
Meelis Roos (mroos@linux.ee)
