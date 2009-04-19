From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Apr 2009 09:16:21 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <Pine.SOC.4.64.0904191215070.21597@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ok, following through on this... Here is how I would like to
> fix this bug.
> 
> sparc: Fix bus type probing for ESP and LE devices.
> 
> If there is a dummy "espdma" or "ledma" parent device above ESP scsi
> or LE ethernet device nodes, we have to match the bus as SBUS.

Unfortunately it does not work, onboard ESP is still not detected on my 
Ultra 1.

-- 
Meelis Roos (mroos@linux.ee)
