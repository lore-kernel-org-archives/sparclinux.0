From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Jan 2009 11:08:22 +0000
Subject: Re: Unknown CPU in 2.6.29-rc1
Message-Id: <Pine.SOC.4.64.0901161306520.2120@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> After Sam's insw/... fix, todays 2.6.29-rc1+git boots up and seems fo 
> work on E3500 with 2 USII-400's. However, the CPU has suddenly became 
> unknown (it was known in 2.6.27):

There's one more difference that shouldn't matter but who knows: the key 
is now in 'Diag' position, not 'On'. AFAIK it only matters what diags 
are run and where to boot from, but...

-- 
Meelis Roos (mroos@linux.ee)
