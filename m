From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 09:24:34 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080821.022434.193706469.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 12:13:21 +0300 (EEST)

> Some it seems something is causing the CPU to get stuck in either after 
> libata detection or during ohci detection and then even sysrq does not 
> work.

It's getting hung in the setup of some module it seems.

I did some looking again, and it turns out that "initcall_debug"
does work for modules, rejoice!

Please add "initcall_debug" to the kernel boot command line,
that will print the last module initialization function that
gets called right before it hangs.
