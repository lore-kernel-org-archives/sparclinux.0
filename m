From: Meelis Roos <mroos@linux.ee>
Date: Tue, 06 May 2014 22:41:08 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405070137280.9443@math.ut.ee>
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

Will try V210/V240/V440/T2000 when I get time.

> You said they have the same problem with THP disabled too, right?

U1/U2/E220R/E420R/E250/E450/E3500 were stable with THP off for my 
dist-upgrade+compile test, Netra X1 and V100 had ocassional trouble. Of 
these, one might have had THP set to madvise.

-- 
Meelis Roos (mroos@linux.ee)
