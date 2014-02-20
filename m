From: David Miller <davem@davemloft.net>
Date: Thu, 20 Feb 2014 00:50:07 +0000
Subject: Re: [PATCH] sparc32: fix build failure for arch_jump_label_transform
Message-Id: <20140219.195007.1409896950208101052.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1392317864-24746-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1392317864-24746-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 13 Feb 2014 13:57:44 -0500

> In arch/sparc/Kernel/Makefile, we see:
> 
>    obj-$(CONFIG_SPARC64)   += jump_label.o
> 
> However, the Kconfig selects HAVE_ARCH_JUMP_LABEL unconditionally
> for all SPARC.  This in turn leads to the following failure when
> doing allmodconfig coverage builds:
> 
> kernel/built-in.o: In function `__jump_label_update':
> jump_label.c:(.text+0x8560c): undefined reference to `arch_jump_label_transform'
> kernel/built-in.o: In function `arch_jump_label_transform_static':
> (.text+0x85cf4): undefined reference to `arch_jump_label_transform'
> make: *** [vmlinux] Error 1
> 
> Change HAVE_ARCH_JUMP_LABEL to be conditional on SPARC64 so that it
> matches the Makefile.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
