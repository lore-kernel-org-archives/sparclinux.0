From: David Miller <davem@davemloft.net>
Date: Thu, 11 Aug 2011 12:44:34 +0000
Subject: Re: Simple piece of code with unexpected behavior
Message-Id: <20110811.054434.2010466021650439185.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4E43CB0F.7050700@broadcom.com>
In-Reply-To: <4E43CB0F.7050700@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Roland Vossen" <rvossen@broadcom.com>
Date: Thu, 11 Aug 2011 14:29:03 +0200

> after compiling and insmodding a module on a Sparc64 machine, the
> following piece of code:
> 
> 	u8 index;
>         for (index = 0; index < 128U; index++) {
>                 if (index=129) {
>                         printk("fishy...\n");
>                         break;
>                 }
>         }
> 
> produces the log message: 'fishy...'.

Something is very wrong with your build environment:

--------------------
root@firepit:/home/davem# cat Makefile 
obj-m := test_mod.o
root@firepit:/home/davem# cat test_mod.c
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/types.h>

static int __init test(void)
{
        u8 index;
        for (index = 0; index < 128U; index++) {
                if (index=129) {
                        printk("fishy...\n");
                        break;
                }
        }
        return 0;
}
module_init(test);
root@firepit:/home/davem# 
root@firepit:/home/davem# make -C /home/davem/src/GIT/linux M=$(pwd)
make: Entering directory `/home/davem/src/GIT/linux'
  CC [M]  /home/davem/test_mod.o
  Building modules, stage 2.
  MODPOST 1 modules
  LD [M]  /home/davem/test_mod.ko
make: Leaving directory `/home/davem/src/GIT/linux'
root@firepit:/home/davem# insmod ./test_mod.ko
--------------------

Generates no warning "fishy" message for me on sparc64.
