From: Meelis Roos <mroos@linux.ee>
Date: Wed, 07 May 2014 18:19:03 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405071814540.15220@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > How should I continue debugging it - find the conf differences with 
> > Debian kernel?
> > 
> > Or do you want my .config for U2, X1, V100?
> 
> I think the pattern is that the UltraSPARC-III based machines have
> no problems, whereas the UltraSPARC-I and UltraSPARC-II based ones
> tend to crash and hang.

With THP on, V440 survived, U5 did not survive - that matches.

E220R survived for many hours with THP off and died on first try with 
THP on - this also matches.

Just got the new patch, will try soon.

-- 
Meelis Roos (mroos@linux.ee)
