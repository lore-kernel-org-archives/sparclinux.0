From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jul 2008 10:01:38 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080703.030138.188642502.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jul 2008 01:12:53 -0700 (PDT)

> From: David Miller <davem@davemloft.net>
> Date: Thu, 03 Jul 2008 00:50:52 -0700 (PDT)
> 
> In file included from include/asm-sparc/page.h:6,
>                  from include/asm/page.h:1,
>                  from arch/sparc64/kernel/vmlinux.lds.S:3:
> include/asm-sparc/page_32.h:24:25: error: asm/btfixup.h: No such file or directory

Sam, because of this, I'm reverting the tree back to
20c51e6 ("sparc64 Kbuild: apb.h and bbc.h should not be exported to userspace")
