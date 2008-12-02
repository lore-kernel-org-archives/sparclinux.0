From: Robert Reif <reif@earthlink.net>
Date: Tue, 02 Dec 2008 01:21:40 +0000
Subject: Re: [PATCH] sparc: fix boot regression
Message-Id: <49348DA4.1040507@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081201185125.GA2379@uranus.ravnborg.org>
In-Reply-To: <20081201185125.GA2379@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> >From e3b6fc4081669054768f93ea2605d1eba8e1b256 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 1 Dec 2008 19:41:49 +0100
> Subject: [PATCH] sparc: fix boot regression
>
> Robert reported that 21cb8a43216e0595b466e903e0f2a7ae615d9e11
> ("sparc: refactor Makefile") caused a boot regression on sparc.
> We tracked it down to the removal of the export of kallsyms.o.
>
> This patch adds back the export and the code that was removed
> in a subsequent commit which uses the exported variable.
> Why this caused a boot regression is not understood atm.
>
> Robert tested a simpler version of this patch and reported success.
>
> Reported-by: Robert Reif <reif@earthlink.net>
> Tested-by: Robert Reif <reif@earthlink.net>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> The patch is made on top of sparc-next.
> Robert - I would appreciate if you could retest on top of
> sparc-next and confirm that the boot regression is really
> fixed there.
> I added a "Tested-by" since you tested the first version
> but would like you to really test this before Dave apply it.
>
> Note: Applying this will most likely cause a few trivial
> conflicts that I posted yesterday.
> But lets sort out this and then revisit that patch-set.
>
> Thanks,
>
> 	Sam
>
>
>  arch/sparc/Makefile      |    4 ++++
>  arch/sparc/boot/Makefile |    2 +-
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 6df8eb5..317aad6 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -89,6 +89,10 @@ VMLINUX_MAIN := $(core-y) kernel/ mm/ fs/ ipc/ security/ crypto/ block/
>  VMLINUX_MAIN += $(patsubst %/, %/lib.a, $(libs-y)) $(libs-y)
>  VMLINUX_MAIN += $(drivers-y) $(net-y)
>  
> +ifdef CONFIG_KALLSYMS
> +export kallsyms.o := .tmp_kallsyms2.o
> +endif
> +
>  boot-y                 := arch/sparc/boot
>  boot-$(CONFIG_SPARC64) := arch/sparc64/boot
>  
> diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
> index 74ba65b..06b653d 100644
> --- a/arch/sparc/boot/Makefile
> +++ b/arch/sparc/boot/Makefile
> @@ -42,7 +42,7 @@ BTOBJS := $(patsubst %/, %/built-in.o, $(VMLINUX_INIT))
>  BTLIBS := $(patsubst %/, %/built-in.o, $(VMLINUX_MAIN))
>  LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) \
>                    --start-group $(BTLIBS) --end-group \
> -                  $(obj)/btfix.o
> +                  $(kallsyms.o) $(obj)/btfix.o
>  
>  # Link the final image including btfixup'ed symbols.
>  # This is a replacement for the link done in the top-level Makefile
>   
This patch also works.
