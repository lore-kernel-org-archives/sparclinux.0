From: Rusty Russell <rusty@rustcorp.com.au>
Date: Sun, 06 Nov 2005 06:27:20 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1131258440.12902.28.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2005-11-05 at 16:40 -0800, David S. Miller wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> Date: Tue, 11 Oct 2005 20:03:36 +1000
> 
> > > > #define __EXPORT_SPECIAL_SYMBOL(name, sym) \
> > > > 	static const char __kstrtab_##name[]			\
> > > > 	__attribute__((section("__ksymtab_strings")))		\
> > > > 	= MODULE_SYMBOL_PREFIX #name;    			\
> > > > 	static const struct kernel_symbol __ksymtab_##name	\
> > > > 	__attribute_used__					\
> > > > 	__attribute__((section("__ksymtab"), unused))	\
> > > > 	= { (unsigned long)&sym, __kstrtab_##name }
> > > > 
> > > > Note, PPC64 still needs the dot hack because it changes the name of
> > > > *every* function symbol.
> 
> How is this special export macro supposed to work?

Argh, it would need to use the alias trick, yes.  As I said, untested.
But, looking in 2.6.12, sparc already did this aliasing?

So my question is (I missed the beginning of this thread), why do you
want to avoid the simple "omit the . at the front" name mangling scheme
which modpost, kernel/module.c and module-init-tools already understand,
and use a different mangling scheme?  Name clash with something else?
Why is "_Udiv" a better name than "udiv"?

And we shouldn't make it ifdef __sparc__ in module-init-tools anyway,
since depmod is supposed to be platform neutral.  Would have to be
special case on ELF header or on names.

Rusty.		
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

