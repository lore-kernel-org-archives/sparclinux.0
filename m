From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 22:46:42 +0000
Subject: Re: [PATCH 3/3] sparc32: probe for cpu info only during startup
Message-Id: <20110421.154642.112612262.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1303330141-31123-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1303330141-31123-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 22:09:01 +0200

> We did a cpu_probe() call each time a CPU got online - which
> only effect was to save latest CPU/FPU info for use by show_cpuinfo().
> Use same setup as for sparc64 where we probe for this info during startup,
> and only once.
> 
> This allowed us to annotate a few functions __init which again
> fixed the following section mismatch warnings:
> 
> WARNING: vmlinux.o(.text+0x65f0): Section mismatch in reference from the function set_cpu_and_fpu() to the (unknown reference) .init.rodata:(unknown)
> WARNING: vmlinux.o(.text+0x65f8): Section mismatch in reference from the function set_cpu_and_fpu() to the (unknown reference) .init.rodata:(unknown)
> WARNING: vmlinux.o(.text+0x664c): Section mismatch in reference from the function set_cpu_and_fpu() to the variable .init.rodata:manufacturer_info
> WARNING: vmlinux.o(.text+0x6650): Section mismatch in reference from the function set_cpu_and_fpu() to the variable .init.rodata:manufacturer_info
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next-2.6
