From: David Miller <davem@davemloft.net>
Date: Wed, 20 Aug 2008 10:55:49 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080820.035549.193701444.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 20 Aug 2008 13:45:13 +0300 (EEST)

> By the way, David - Sysrq-T and Sysrq-P do not seem to work in latest 
> git form me for some reason, from serial console. So no new trace.

That's very weird.

> Will check the kernel debugging options with working U5 config to look 
> for any suspicios diffences there.
> 
> What should I do next - probably go back to the original revision and 
> instrument ohci_hub_status_data() there?

If you enable all of the spinlock etc. debugging, it should print
at least some message after being wedged for 30 or 60 seconds via
the software watchdog or the spinlock debugging timeout code.
