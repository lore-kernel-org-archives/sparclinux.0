From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 14 Feb 2016 10:51:31 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <20160214105131.GD20715@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (02/05/16 11:06), Meelis Roos wrote:
> It's getting more strange. I ran 4.4-rc8-00005 for 2-3 weeks nonstop, 
> doing git clone and make -j4 in a loop, on both V240 and V440. Worked 
> 100% stable.
> 
> Then I git git pull from kernel.org, tried to compile 4.5-rc1 (or was it 
> rc2 already), on the same running 4.4.0-rc8-00005 and it rebooted, on 
> both V240 and V440.

sorry for not getting back sooner - was on the road, and will be
mostly offline again next week. But the symptoms sound like there 
might be a memory and/or compiler issue. I'm not sure how to check this
theory out.. maybe someone else with more expertise in this space
can check?

If not, I can come back and try this out in a week- will take
some extra config/pkg-installation in my test machine to get around
firewalls etc and run git directly from the sunfire.

--Sowmini

