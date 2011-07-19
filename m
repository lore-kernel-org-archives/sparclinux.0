From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 19 Jul 2011 21:06:01 +0000
Subject: Re: [PATCH] sparc,kgdbts: fix compile regression with kgdb test suite
Message-Id: <CAJaTeTr1HxcEX9MT83iDZHmCyE=yGhXYDUB0xBmwAn43F_+4ew@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1311109112-12909-1-git-send-email-jason.wessel@windriver.com>
In-Reply-To: <1311109112-12909-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Wessel <jason.wessel@windriver.com>
Cc: davem@davemloft.net, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, Jul 19, 2011 at 16:58, Jason Wessel wrote:
> Commit 63ab25ebbc (kgdbts: unify/generalize gdb breakpoint adjustment)
> introduced a compile regression on sparc.
>
> kgdbts.c: In function 'check_and_rewind_pc':
> kgdbts.c:307: error: implicit declaration of function 'instruction_pointer_set'
>
> Simply add the correct macro definition for instruction pointer on the
> Sparc architecture.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
