From: David Miller <davem@davemloft.net>
Date: Wed, 19 Oct 2011 04:07:00 +0000
Subject: Re: [PATCH 3/4] sparc32: return destination pointer on return from
Message-Id: <20111019.000700.1958065818398834929.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1318489205-315-4-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318489205-315-4-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 13 Oct 2011 09:00:04 +0200

> -/* In kernel these functions don't return a value.
> - * One should use macros in asm/string.h for that purpose.
> - * We return 0, so that bugs are more apparent.
> - */
> -#define SETUP_RETL
> -#define RETL_INSN	clr	%o0
> +#define SETUP_RETL	mov	%o0, %g6
> +#define RETL_INSN	mov	%g6, %o0

Sigh...

The kernel uses %g6 as the global thread register, see
include/asm/thread_info_32.h:

register struct thread_info *current_thread_info_reg asm("g6");

Your kernel would have crashed early in the boot if you actually
tested this patch.
