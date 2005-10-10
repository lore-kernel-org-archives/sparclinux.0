From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 10 Oct 2005 14:35:38 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1128954938.6766.133.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2005-10-10 at 20:20 +1000, Rusty Russell wrote:

> #define __EXPORT_SPECIAL_SYMBOL(name, sym) \
> 	static const char __kstrtab_##name[]			\
> 	__attribute__((section("__ksymtab_strings")))		\
> 	= MODULE_SYMBOL_PREFIX #name;    			\
> 	static const struct kernel_symbol __ksymtab_##name	\
> 	__attribute_used__					\
> 	__attribute__((section("__ksymtab"), unused))	\
> 	= { (unsigned long)&sym, __kstrtab_##name }

Umm... isn't this how sparc used to do things? I think we're going in
circles here...

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

