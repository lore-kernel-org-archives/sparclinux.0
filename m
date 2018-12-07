From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 07 Dec 2018 17:42:32 +0000
Subject: Re: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
Message-Id: <20181207174231.GD11961@arrakis.emea.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181205033828.6156-1-dianders@chromium.org>
In-Reply-To: <20181205033828.6156-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Douglas Anderson <dianders@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Huang Ying <ying.huang@intel.com>, James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, Dec 04, 2018 at 07:38:24PM -0800, Douglas Anderson wrote:
> Douglas Anderson (4):
>   kgdb: Remove irq flags from roundup
>   kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
>   kgdb: Don't round up a CPU that failed rounding up before
>   kdb: Don't back trace on a cpu that didn't round up

FWIW, trying these on arm64 (ThunderX2) with CONFIG_KGDB_TESTS_ON_BOOT=y
on top of 4.20-rc5 doesn't boot. It looks like they leave interrupts
disabled when they shouldn't and it trips over the BUG at
mm/vmalloc.c:1380 (called via do_fork -> copy_process).

Now, I don't think these patches make things worse on arm64 since prior
to them the kgdb boot tests on arm64 were stuck in a loop (RUN
singlestep).

-- 
Catalin
