From: Meelis Roos <mroos@linux.ee>
Date: Thu, 11 Sep 2008 10:36:16 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809111328240.7394@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Well, do you have sunzilog and sunzilog console support built into
> this kernel?
> 
> Just making sure :)

Good question - the kernel config was for my U5...
I had sunsu and sundab but no zilog8350. 

Enabled that and applied the patch, now waiting for a trip to the 
location of the E3500.

-- 
Meelis Roos (mroos@linux.ee)
