From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 01 Jul 2008 15:46:48 +0000
Subject: Re: next-0630: sparc64: build failed
Message-Id: <20080701154648.GA31057@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807010825t7ea2eb44oda3f08dc007c40a2@mail.gmail.com>
In-Reply-To: <a4423d670807010825t7ea2eb44oda3f08dc007c40a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, sagar.abhishek@gmail.com, rostedt@goodmis.org


* Alexander Beregalov <a.beregalov@gmail.com> wrote:

> Hi David, Abhishek
> 
> $ make CROSS_COMPILE=sparc64-unknown-linux-gnu- image modules && sudo
> make modules_install
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>   CC      arch/sparc64/kernel/sparc64_ksyms.o
> arch/sparc64/kernel/sparc64_ksyms.c:116: error: '_mcount' undeclared
> here (not in a function)
> cc1: warnings being treated as errors
> arch/sparc64/kernel/sparc64_ksyms.c:116: error: type defaults to 'int'
> in declaration of '_mcount'
> 
> This commit is cause.
> 
> commit 395a59d0f8e86bb39cd700c3d185d30c670bb958
> Author: Abhishek Sagar <sagar.abhishek@gmail.com>
> Date:   Sat Jun 21 23:47:27 2008 +0530
> 
>     ftrace: store mcount address in rec->ip

thanks Alexander - does the patch below fix it for you?

	Ingo

---------------->
commit 760378e1497841246ea7e42abad617d8a8ac0bcc
Author: Ingo Molnar <mingo@elte.hu>
Date:   Tue Jul 1 17:35:06 2008 +0200

    fix "ftrace: store mcount address in rec->ip"
    
    Alexander Beregalov reported this build failure:
    
    $ make CROSS_COMPILE=sparc64-unknown-linux-gnu- image modules && sudo
    make modules_install
      CHK     include/linux/version.h
      CHK     include/linux/utsrelease.h
      CALL    scripts/checksyscalls.sh
      CHK     include/linux/compile.h
    dnsdomainname: Unknown host
      CC      arch/sparc64/kernel/sparc64_ksyms.o
    arch/sparc64/kernel/sparc64_ksyms.c:116: error: '_mcount' undeclared
    here (not in a function)
    cc1: warnings being treated as errors
    arch/sparc64/kernel/sparc64_ksyms.c:116: error: type defaults to 'int'
    in declaration of '_mcount'
    
    And bisected it back to:
    
    | commit 395a59d0f8e86bb39cd700c3d185d30c670bb958
    | Author: Abhishek Sagar <sagar.abhishek@gmail.com>
    | Date:   Sat Jun 21 23:47:27 2008 +0530
    |
    |     ftrace: store mcount address in rec->ip
    
    the mcount prototype is only available under CONFIG_FTRACE,
    extend it to CONFIG_MCOUNT as well.
    
    Reported-and-bisected-by: Alexander Beregalov <a.beregalov@gmail.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index b80d982..49d3ea5 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -112,7 +112,7 @@ EXPORT_SYMBOL(__write_trylock);
 EXPORT_SYMBOL(smp_call_function);
 #endif /* CONFIG_SMP */
 
-#if defined(CONFIG_MCOUNT)
+#ifdef CONFIG_MCOUNT
 EXPORT_SYMBOL(_mcount);
 #endif
 
diff --git a/include/asm-sparc64/ftrace.h b/include/asm-sparc64/ftrace.h
index f76a40a..d27716c 100644
--- a/include/asm-sparc64/ftrace.h
+++ b/include/asm-sparc64/ftrace.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_SPARC64_FTRACE
 #define _ASM_SPARC64_FTRACE
 
-#ifdef CONFIG_FTRACE
+#ifdef CONFIG_MCOUNT
 #define MCOUNT_ADDR		((long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 
