From: Meelis Roos <mroos@linux.ee>
Date: Tue, 18 Sep 2007 14:45:54 +0000
Subject: Re: [PATCH]: Fix for several sunsab problems.
Message-Id: <Pine.SOC.4.64.0709181744500.25760@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20070917.185701.13769540.davem@davemloft.net>
In-Reply-To: <20070917.185701.13769540.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Some folks (Meelis I think you were one) reported some
> issues with serial console on sunsab sometimes hanging
> or similar on bootup.
> 
> Al Viro found and fixed several bugs in this driver which
> could definitely cause that behavior.  I include that patch
> below and have pushed this onward to Linus's tree and
> will also submit it to -stable as well.

First test was successful, will try to reintorduce my random 
hang-on-boot.

-- 
Meelis Roos (mroos@linux.ee)
