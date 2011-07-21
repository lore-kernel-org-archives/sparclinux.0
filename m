From: David Miller <davem@davemloft.net>
Date: Thu, 21 Jul 2011 21:45:16 +0000
Subject: Re: [PATCH] sparc,kgdbts: fix compile regression with kgdb test
Message-Id: <20110721.144516.549074030873550786.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1311109112-12909-1-git-send-email-jason.wessel@windriver.com>
In-Reply-To: <1311109112-12909-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jason.wessel@windriver.com
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, vapier@gentoo.org

From: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 19 Jul 2011 15:58:32 -0500

> Commit 63ab25ebbc (kgdbts: unify/generalize gdb breakpoint adjustment)
> introduced a compile regression on sparc.
> 
> kgdbts.c: In function 'check_and_rewind_pc':
> kgdbts.c:307: error: implicit declaration of function 'instruction_pointer_set'
> 
> Simply add the correct macro definition for instruction pointer on the
> Sparc architecture.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>

Acked-by: David S. Miller <davem@davemloft.net>
