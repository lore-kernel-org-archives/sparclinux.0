From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 26 Apr 2019 00:40:46 +0000
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
Message-Id: <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>
Cc: "ndesaulniers@google.com" <ndesaulniers@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ingo Molnar <mingo@kernel.org>

Hi David,


On Wed, Apr 3, 2019 at 5:34 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> $(call if_changed,...) must have FORCE as a prerequisite.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping?


>  arch/sparc/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 74e97f7..83c4b46 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -68,7 +68,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
>
>  $(obj)/%.so: OBJCOPYFLAGS := -S
> -$(obj)/%.so: $(obj)/%.so.dbg
> +$(obj)/%.so: $(obj)/%.so.dbg FORCE
>         $(call if_changed,objcopy)
>
>  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> --
> 2.7.4
>


--
Best Regards
Masahiro Yamada
