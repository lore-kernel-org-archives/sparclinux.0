From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Sep 2016 04:50:13 +0000
Subject: Re: [PATCH] Sparc/prom/ranges.c cosmetic improvement
Message-Id: <20160929045013.GA30814@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160928214625.GA24725@netmonk.localdomain>
In-Reply-To: <20160928214625.GA24725@netmonk.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Sep 28, 2016 at 11:46:25PM +0200, netmonk@netmonk.org wrote:
> Following Linux Coding Style documentation, removed, added some spaces 
> to improve compliance to the formating standard.
> 
> Signed-of-by: Netmonk <netmonk@netmonk.org>
> 
> 

> >From 276b83b74716cbd39c6c72428c6e385881b089e7 Mon Sep 17 00:00:00 2001
> From: netmonk <netmonk@netmonk.org>
> Date: Wed, 28 Sep 2016 23:26:33 +0200
> Subject: [PATCH]  Cosmetic improvement in arch/sparc/prom/ranges.c
> 
> ---
>  arch/sparc/prom/ranges.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
> index ad143c1..a493de3 100644
> --- a/arch/sparc/prom/ranges.c
> +++ b/arch/sparc/prom/ranges.c
> @@ -16,8 +16,7 @@ static struct linux_prom_ranges promlib_obio_ranges[PROMREG_MAX];
>  static int num_obio_ranges;
>  
>  /* Adjust register values based upon the ranges parameters. */
> -static void
> -prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
> +static void prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
>  		 struct linux_prom_ranges *rangep, int nranges)

The arguments on the second line shall be aligned with the first line.
Use tabs and then the number of spaces required.
In this case "struct linux_*" and "struct linux_*" shall be just below each other.
Fix up similar bug in rest of the patch.

	Sam
