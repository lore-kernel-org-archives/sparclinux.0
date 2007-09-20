From: Meelis Roos <mroos@linux.ee>
Date: Thu, 20 Sep 2007 09:16:22 +0000
Subject: Re: [PATCH]: Fix for several sunsab problems.
Message-Id: <Pine.SOC.4.64.0709201214180.3972@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20070917.185701.13769540.davem@davemloft.net>
In-Reply-To: <20070917.185701.13769540.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Some folks (Meelis I think you were one) reported some
> > issues with serial console on sunsab sometimes hanging
> > or similar on bootup.
> 
> First test was successful, will try to reintorduce my random 
> hang-on-boot.

Tested it more on U5, the serial-related boot OOPSes are gone it seems. 

Boot hang when I just change page size from 8k to 64k remains, will try 
to find a less intrusive change that triggers is (I seem to remember 
seeing 64k pages working too in some conf).

-- 
Meelis Roos (mroos@linux.ee)
