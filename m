From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 27 Mar 2018 06:09:11 +0000
Subject: Re: [PATCH v2,10/10] kbuild: mark $(targets) as .SECONDARY and remove .PRECIOUS markers
Message-Id: <20180327060911.iljk66zfuqnl472e@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1522079634-5947-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1522079634-5947-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> GNU Make automatically deletes intermediate files that are updated
> in a chain of pattern rules.
> 
> Example 1) %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
> Example 2) %.o <- %.c <- %.c_shipped
> 
> A couple of makefiles mark such targets as .PRECIOUS to prevent Make
> from deleting them, but the correct way is to use .SECONDARY.
> 
>   .SECONDARY
>     Prerequisites of this special target are treated as intermediate
>     files but are never automatically deleted.
> 
>   .PRECIOUS
>     When make is interrupted during execution, it may delete the target
>     file it is updating if the file was modified since make started.
>     If you mark the file as precious, make will never delete the file
>     if interrupted.
> 
> Both can avoid deletion of intermediate files, but the difference is
> the behavior when Make is interrupted; .SECONDARY deletes the target,
> but .PRECIOUS does not.
> 
> The use of .PRECIOUS is relatively rare since we do not want to keep
> partially constructed (possibly corrupted) targets.
> 
> Another difference is that .PRECIOUS works with pattern rules whereas
> .SECONDARY does not.
> 
>   .PRECIOUS: $(obj)/%.lex.c
> 
> works, but
> 
>   .SECONDARY: $(obj)/%.lex.c
> 
> has no effect.  However, for the reason above, I do not want to use
> .PRECIOUS which could cause obscure build breakage.
> 
> The targets specified as .SECONDARY must be explicit.  $(targets)
> contains all targets that need to include .*.cmd files.  So, the
> intermediates you want to keep are mostly in there.  Therefore, mark
> $(targets) as .SECONDARY.  It means primary targets are also marked
> as .SECONDARY, but I do not see any drawback for this.
> 
> I replaced some .SECONDARY / .PRECIOUS markers with 'targets'.  This
> will make Kbuild search for non-existing .*.cmd files, but this is
> not a noticeable performance issue.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> ---
>  arch/arc/boot/dts/Makefile        |  2 --
>  arch/arm/crypto/Makefile          |  2 +-
>  arch/arm64/crypto/Makefile        |  2 +-
>  arch/metag/boot/dts/Makefile      |  2 --
>  arch/sparc/vdso/Makefile          |  4 +---
>  arch/x86/entry/vdso/Makefile      |  4 +---

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
