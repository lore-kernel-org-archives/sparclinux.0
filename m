From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2009 09:25:08 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <20090422.022508.214852584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2009 02:16:31 -0700 (PDT)

> From: Meelis Roos <mroos@linux.ee>
> Date: Sun, 19 Apr 2009 12:16:21 +0300 (EEST)
> 
>>> Ok, following through on this... Here is how I would like to
>>> fix this bug.
>>> 
>>> sparc: Fix bus type probing for ESP and LE devices.
>>> 
>>> If there is a dummy "espdma" or "ledma" parent device above ESP scsi
>>> or LE ethernet device nodes, we have to match the bus as SBUS.
>> 
>> Unfortunately it does not work, onboard ESP is still not detected on my 
>> Ultra 1.
> 
> Silly bug in that patch, I forgot to substitude "np" with "dp" in
> the name tests that got moved into the loop.
> 
> Please try this patch instead.
> 
> Thanks!

Meelis, have you have an opportunity to test this updated
version of the fix yet?

Thanks.
