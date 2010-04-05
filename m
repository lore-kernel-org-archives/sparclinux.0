From: Paul Mackerras <paulus@samba.org>
Date: Mon, 05 Apr 2010 09:38:58 +0000
Subject: Re: [PATCH] sparc64: Implement perf_arch_fetch_caller_regs
Message-Id: <20100405093858.GB4471@brick.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100403.235922.169556601.davem@davemloft.net>
In-Reply-To: <20100403.235922.169556601.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Apr 03, 2010 at 11:59:22PM -0700, David Miller wrote:

> Paulus, I noticed while writing this that you don't seem to provide
> some form of the processor status register on powerpc, which is
> necessary to resolve user_mode() and perf_misc_flags() in these
> code paths.

Yes, I just left regs->msr as zero in the first version of Frederic's
API, but in what I did for Frederic's new API, I added code to read
the MSR and store that.

> Maybe your status register, when zero, means !user_mode() and nops out
> perf_misc_flags() as well, and that's how it all just works itself
> out?

Yes.

Paul.
