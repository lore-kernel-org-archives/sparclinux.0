From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 18:22:46 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20051010.112246.111373395.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Mon, 10 Oct 2005 20:20:52 +1000

> #define __EXPORT_SPECIAL_SYMBOL(name, sym) \
> 	static const char __kstrtab_##name[]			\
> 	__attribute__((section("__ksymtab_strings")))		\
> 	= MODULE_SYMBOL_PREFIX #name;    			\
> 	static const struct kernel_symbol __ksymtab_##name	\
> 	__attribute_used__					\
> 	__attribute__((section("__ksymtab"), unused))	\
> 	= { (unsigned long)&sym, __kstrtab_##name }
> 
> Note, PPC64 still needs the dot hack because it changes the name of
> *every* function symbol.

The reason we did the ".foo" --> "_Foo" transformation was
exactly because we didn't want to do crap like this any more.

It's error prone, and is nearly impossible to get working with
every version of the compiler.

Why don't we just put an ifdef __sparc__ thing into modutils
which understands the ".foo" --> "_Foo" translation?
