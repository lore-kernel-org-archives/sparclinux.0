From: Paul Burton <paul.burton@mips.com>
Date: Thu, 06 Dec 2018 18:05:41 +0000
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Message-Id: <20181206180539.fezd6bqce36tgmie@pburton-laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
In-Reply-To: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Rich Felker <dalias@libc.org>, "Gustavo A. R.
 Silva" <gustavo@embeddedor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>, Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Jason Wessel <jason.wessel@windriver.com>, "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>, Ley Foon Tan <lftan@altera.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S.
 Miller" <davem@davemloft.net>

Hi Christophe & Daniel,

On Thu, Dec 06, 2018 at 02:09:02PM +0000, Daniel Thompson wrote:
> On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
> > MIPS is the only architecture modifying arch_kgdb_ops during init.
> > This patch makes the init static, so that it can be changed to
> > const in following patch, as recommended by checkpatch.pl
> > 
> > Suggested-by: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> From my side this is
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Since this is a dependency for the next patch I'd be happy to take via
> my tree... but would need an ack from the MIPS guys to do that.

For both patches in this series:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
