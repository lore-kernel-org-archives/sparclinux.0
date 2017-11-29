From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 18:38:25 +0000
Subject: Re: [PATCH 1/2] sparc32,leon: Build with -mcpu=leon3 for SPARC_LEON
Message-Id: <20171129.133825.1224896993681699024.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1510668223-18484-1-git-send-email-andreas@gaisler.com>
        <1510668223-18484-2-git-send-email-andreas@gaisler.com>
In-Reply-To: <1510668223-18484-2-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 14 Nov 2017 15:03:42 +0100

> Apart from using LEON3 instruction timing it allows for usage of the
> CASA instruction.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Up until this point the LEON kconfig option is largely passive.

All of the sparc_cpu_type logic drives what parts of the kernel are
used based upon the run-time detected cpu type.

But with this change, it completely breaks the 32-bit sparc kernel
on any non-Leon processor.

I wish you would reconsider this approach, and instead do hardcoded
assembler instruction opcodes to use "casa" in assembler, and run
time detect CAS support in the 32-bit cpu.

Thank you.
