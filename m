From: "David S. Miller" <davem@redhat.com>
Date: Mon, 02 Feb 2004 21:22:40 +0000
Subject: Re: sparc32 module status
Message-Id: <20040202132240.5df04664.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040202095005.GD22498@foobazco.org>
In-Reply-To: <20040202095005.GD22498@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2 Feb 2004 01:50:05 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> === arch/sparc/kernel/sparc_ksyms.c 1.22 vs edited ==> --- 1.22/arch/sparc/kernel/sparc_ksyms.c	Sat Dec 27 01:38:21 2003
> +++ edited/arch/sparc/kernel/sparc_ksyms.c	Mon Feb  2 00:07:45 2004
 ...
> +#ifdef CONFIG_MODULES


Keith, why not just "obj-$(CONFIG_MODULES) += sparc_ksyms.o" then
remove sparc_ksyms.o from the obj-y in arch/sparc/kernel/Makefile?

Let me know when you have a version of this patch you'd like me to apply.

Thanks.
