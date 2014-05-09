From: Meelis Roos <mroos@linux.ee>
Date: Fri, 09 May 2014 05:37:04 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405090759530.12382@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ok, let's try the following patch as a test, it will kind of let me
> know if I'm barking up the wrong tree or not.
> 
> This basically turns off the TSB path entirely in the TLB miss handler
> for THP mappings.
> 
> Let me know if this changes the behavior on your Ultra-I/II machines.

Unfortunately it did not change anything on X1, V100 or U5.

-- 
Meelis Roos (mroos@linux.ee)
