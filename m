From: David Miller <davem@davemloft.net>
Date: Mon, 17 Sep 2012 16:27:22 +0000
Subject: Re: [PATCH] sparc32: Enable the relocation target R_SPARC_DISP32 for sparc32
Message-Id: <20120917.122722.2202914693352843309.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1347895348-24728-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1347895348-24728-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 17 Sep 2012 17:22:28 +0200

> GNU Binutils 2.20.1 generates .eh_frame sections that uses R_SPARC_DISP32.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  arch/sparc/kernel/module.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index 15e0a16..f42ab3e 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -116,6 +116,11 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
>  		v = sym->st_value + rel[i].r_addend;
>  
>  		switch (ELF_R_TYPE(rel[i].r_info) & 0xff) {
> +

Please get rid of the empty line and resubmit, thanks.
