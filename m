From: David Miller <davem@davemloft.net>
Date: Fri, 30 Mar 2012 20:47:37 +0000
Subject: Re: [PATCH] sparc: fix compile failure in kgdb_64.c
Message-Id: <20120330.164737.2235397207407153608.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 30 Mar 2012 15:31:24 -0400

> To fix:
> 
>   CC      arch/sparc/kernel/kgdb_64.o
>  arch/sparc/kernel/kgdb_64.c: In function 'smp_kgdb_capture_client':
>  arch/sparc/kernel/kgdb_64.c:121: error: implicit declaration of function 'flushw_all'
>  make[2]: *** [arch/sparc/kernel/kgdb_64.o] Error 1
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I already pushed this fix to Linus last night.
