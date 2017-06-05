From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 15:59:32 +0000
Subject: Re: sparc64 gcc 7.1 compile error
Message-Id: <20170605.115932.676337842945675142.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170605091941.GM26922@waldemar-brodkorb.de>
In-Reply-To: <20170605091941.GM26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wbx@openadk.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Waldemar Brodkorb <wbx@openadk.org>
Date: Mon, 5 Jun 2017 11:19:41 +0200

> I get a compile/linking error with gcc 7.1 when targeting qemu system
> sparc64.
> 
> + objects='arch/sparc/kernel/head_64.o  init/built-in.o
> --start-group  usr/built-in.o  arch/sparc/built-in.o
> kernel/built-in.o  certs/built-in.o  mm/built-in.o  fs/built-in.o
> ipc/built-in.o  security/built-in.o  crypto/built-in.o
> block/built-in.o  lib/lib.a  arch/sparc/prom/lib.a
> arch/sparc/lib/lib.a  lib/built-in.o  arch/sparc/prom/built-in.o
> arch/sparc/lib/built-in.o  drivers/built-in.o  sound/built-in.o
> firmware/built-in.o  net/built-in.o  virt/built-in.o
> --end-group           '
> +
> /home/wbx/openadk/toolchain_qemu-sparc64_glibc_v9/usr/bin/sparc64-openadk-linux-gnu-ld
> -m elf64_sparc --build-id -o vmlinux -T
> ./arch/sparc/kernel/vmlinux.lds arch/sparc/kernel/head_64.o
> init/built-in.o --start-group usr/built-in.o arch/sparc/built-in.o
> kernel/built-in.o certs/built-in.o mm/built-in.o fs/built-in.o
> ipc/built-in.o security/built-in.o crypto/built-in.o
> block/built-in.o lib/lib.a arch/sparc/prom/lib.a
> arch/sparc/lib/lib.a lib/built-in.o arch/sparc/prom/built-in.o
> arch/sparc/lib/built-in.o drivers/built-in.o sound/built-in.o
> firmware/built-in.o net/built-in.o virt/built-in.o --end-group
> ipc/built-in.o: In function `mq_attr_ok':
> mqueue.c:(.text+0x6154): undefined reference to `__multi3'
> 
> I tried with Linux 4.11.3, Linus master and David Miller's SPARC
> tree from today with the same result. The failing config is attached.

GCC seems to be emitting a 128-bit multiply to work out this
expression in ipc/mqueue.c:

 if (attr->mq_msgsize > (~0UL)/attr->mq_maxmsg)
  return -92;

Seems like a bit of an extreme way to do this.

But worst case we'll have to add __multi3 to the kernel libraries.
