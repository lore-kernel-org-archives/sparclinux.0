From: David Miller <davem@davemloft.net>
Date: Sun, 30 Sep 2007 23:59:21 +0000
Subject: Re: SPARC64 2.6.23-rc8 binfmt_aout32 error
Message-Id: <20070930.165921.104060866.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <470034EA.4060906@gmail.com>
In-Reply-To: <470034EA.4060906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Mon, 01 Oct 2007 01:44:42 +0200

> When I'm building 2.6.23-rc8 on SPARC64 (using a 64-bit CLFS
> SVN tool chain consisting of GCC 4.2.1, Binutils 2.18 and Glibc
> 2.6.1) I get the following error:
> 
> >   CC      arch/sparc64/kernel/binfmt_aout32.o
> > cc1: warnings being treated as errors
> > arch/sparc64/kernel/binfmt_aout32.c: In function 'create_aout32_tables':
> > arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> > integer of different size

This patch below will likely fix the build failure.

But note that gcc-4.2.x is very widely known to miscompile
the sparc64 kernel, particularly on SMP, so even if you get
a build the kernel you end up will be mostly unusable.

I would really recommend you stay with gcc-4.1.x unless you are going
to work on fixing those gcc-4.2.x miscompilations, and I'm already on
the hook for that :-)

diff --git a/arch/sparc64/kernel/binfmt_aout32.c b/arch/sparc64/kernel/binfmt_aout32.c
index f205fc7..d208cc7 100644
--- a/arch/sparc64/kernel/binfmt_aout32.c
+++ b/arch/sparc64/kernel/binfmt_aout32.c
@@ -177,7 +177,7 @@ static u32 __user *create_aout32_tables(char __user *p, struct linux_binprm *bpr
 			get_user(c,p++);
 		} while (c);
 	}
-	put_user(NULL,argv);
+	put_user(0,argv);
 	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
 	while (envc-->0) {
 		char c;
@@ -186,7 +186,7 @@ static u32 __user *create_aout32_tables(char __user *p, struct linux_binprm *bpr
 			get_user(c,p++);
 		} while (c);
 	}
-	put_user(NULL,envp);
+	put_user(0,envp);
 	current->mm->env_end = (unsigned long) p;
 	return sp;
 }
