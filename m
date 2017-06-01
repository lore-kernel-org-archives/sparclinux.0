From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 01 Jun 2017 12:46:04 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <CADxRZqyug5w1+tWpWxAX7aKkom166j=xqHUa-L61EKWEx7XAHw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de> <20170531.171008.528800003662477033.davem@davemloft.net>
 <20170601121224.GE26922@waldemar-brodkorb.de>
In-Reply-To: <20170601121224.GE26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

on the same topic , latest git does not compile for me with gcc-7.0.1
gcc version 7.0.1 20170407 (experimental) [trunk revision 246759]
(Debian 7-20170407-1)

$ make
...
  CC      arch/sparc/kernel/ds.o
arch/sparc/kernel/ds.c: In function ‘register_services’:
arch/sparc/kernel/ds.c:912:3: error: ‘strcpy’: writing at least 1 byte
into a region of size 0 overflows the destination
[-Werror=stringop-overflow ]
   strcpy(pbuf.req.svc_id, cp->service_id);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
scripts/Makefile.build:302: recipe for target 'arch/sparc/kernel/ds.o' failed
make[2]: *** [arch/sparc/kernel/ds.o] Error 1
scripts/Makefile.build:561: recipe for target 'arch/sparc/kernel' failed
make[1]: *** [arch/sparc/kernel] Error 2
Makefile:1016: recipe for target 'arch/sparc' failed
make: *** [arch/sparc] Error 2

I'm able to pass arch/sparc/kernel/ compilation, if I change/add to
arch/sparc/kernel/Makefile :

-ccflags-y := -Werror
+ccflags-y := -Werror -Wno-error=stringop-overflow

but even with that hack, i'm unable to compile kernel, getting in the
end of make:
...
  LD      init/built-in.o
  LD      vmlinux.o
  MODPOST vmlinux.o
ipc/built-in.o: In function `mq_attr_ok.isra.0':
mqueue.c:(.text+0xc490): undefined reference to `__multi3'
drivers/built-in.o: In function `dm_vcalloc':
(.text+0xc9e98): undefined reference to `__multi3'
Makefile:997: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1
