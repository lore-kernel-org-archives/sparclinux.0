From: Kees Cook <keescook@chromium.org>
Date: Wed, 13 Nov 2019 23:59:27 +0000
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
Message-Id: <201911131558.6B0778229@keescook>
List-Id: <sparclinux.vger.kernel.org>
References: <20190922113436.10396-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190922113436.10396-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "ndesaulniers@google.com" <ndesaulniers@google.com>

On Sun, Sep 22, 2019 at 08:34:36PM +0900, Masahiro Yamada wrote:
> Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
> take the path relative to $(obj)"), sparc allmodconfig fails to build
> as follows:
> 
>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> 
> The cause of the breakage is that -pg flag not being dropped.
> 
> The vdso32 files are located in the vdso32/ subdirectory, but I missed
> to update the Makefile.
> 
> Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I've tripped over this as well. Since no one has picked this up, can you
take it via your tree Masahiro?

Thanks!

-Kees

> ---
> 
>  arch/sparc/vdso/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 324a23947585..399bc22b1cf8 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -67,12 +67,14 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS
>  #
>  CFLAGS_REMOVE_vdso-note.o = -pg
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
> +CFLAGS_REMOVE_vdso32/vdso-note.o = -pg
> +CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
>  
>  $(obj)/%.so: OBJCOPYFLAGS := -S
>  $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
> -CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> +CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
>  VDSO_LDFLAGS_vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
>  
>  #This makes sure the $(obj) subdirectory exists even though vdso32/
> -- 
> 2.17.1
> 

-- 
Kees Cook
