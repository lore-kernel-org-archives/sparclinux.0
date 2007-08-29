From: Meelis Roos <mroos@linux.ee>
Date: Wed, 29 Aug 2007 15:08:05 +0000
Subject: Re: ESP: cosmetic printk error during detection
Message-Id: <Pine.SOC.4.64.0708291807120.11995@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0708121438030.24332@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0708121438030.24332@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The first call of scsi_esp_register() (for the controller "0") should
> get unique_id set to 0 and instance incremented to 1, the second call
> (for the controller "1") should get unique_id set to 1 and instance
> incremented to 2, which is what we want.
> 
> The problem is rather that we are not assigning the unique_id early
> enough, and thus we do prints with the value uninitialized to zero.
> 
> Thankfully the bug is purely cosmetic as it only disrupts the probe
> printk statements.
> 
> This patch should fix it up, thanks for the report.

Thank you, it works fine here. I have been slow to test things recently 
but I have not forgotten :)

-- 
Meelis Roos (mroos@linux.ee)
