From: Meelis Roos <mroos@linux.ee>
Date: Thu, 08 May 2014 04:30:57 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405080720120.15220@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Thanks I'll fix my patch up to build properly with THP off, please
> test with THP enabled meanwhile.

All machines are now with THP on and latest git + yesterdays patch:

V440 still works.

V100, Netra X1 and Ultra 5 still hang on first/second git clone :(

So it seems the patch did not fix it yet.

-- 
Meelis Roos (mroos@linux.ee)
