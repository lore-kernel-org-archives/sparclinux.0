From: David Miller <davem@davemloft.net>
Date: Sun, 19 Apr 2009 10:18:57 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <20090419.031857.237985909.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Apr 2009 12:16:21 +0300 (EEST)

>> Ok, following through on this... Here is how I would like to
>> fix this bug.
>> 
>> sparc: Fix bus type probing for ESP and LE devices.
>> 
>> If there is a dummy "espdma" or "ledma" parent device above ESP scsi
>> or LE ethernet device nodes, we have to match the bus as SBUS.
> 
> Unfortunately it does not work, onboard ESP is still not detected on my 
> Ultra 1.

Thanks for testing.  I'll try to figure out why it doesn't work.
