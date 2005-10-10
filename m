From: Rusty Russell <rusty@rustcorp.com.au>
Date: Mon, 10 Oct 2005 10:20:52 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1128939652.5611.67.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2005-10-06 at 08:21 -0500, Tom 'spot' Callaway wrote:
> On Wed, 2005-10-05 at 17:24 -0700, David S. Miller wrote:
> > From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> > Date: Wed, 05 Oct 2005 17:10:54 -0500
> > 
> > > 7caaeabb17758295edff9703c18a840073c5b8f4
> > 
> > This change should cause us to lookup ".[a-z]*" symbols
> > as "_[A-Z]*", as per the change made in handle_modversions()
> > in scripts/mod/modpost.c
> > 
> > So when a module references ".udiv" that symbol reference
> > should get rewritten to "_Udiv" and that latter symbol is
> > what we actually export from the kernel.
> > 
> > As best as I can tell, what is needed is similar logic in
> > depmod.  Ie. something like:
> > 
> > + 			if (symname[0] = '.') {
> > + 				char *munged = strdup(symname);
> > + 				munged[0] = '_';
> > + 				munged[1] = toupper(munged[1]);
> > + 				symname = munged;
> > + 			}
> > 
> > I see you just hardcoded the various ".*" symbol names Sparc
> > uses in your patch.
> 
> My concern was the comment around the existing routine in the depmod
> code:
> 
> /* For our purposes, .foo matches foo.  PPC64 needs this. */
>         if (name[0] = '.')
>                 name++;
> 
> If PPC64 still needs this, we can't just munge to the _<upper> condition
> universally, we still need some mechanism of identifying whether we want
> the PPC64 behavior for dot symbols or the sparc32 behavior for dot
> symbols. By hardcoding the six sparc specific symbols, and changing them
> first, we ensure that the PPC64 case still works.

Anton CC'd.  I think you can and should fix this within sparc32
arch-specific code by creating a macro which can export a symbol by a
different name, eg: (untested)

#define __EXPORT_SPECIAL_SYMBOL(name, sym) \
	static const char __kstrtab_##name[]			\
	__attribute__((section("__ksymtab_strings")))		\
	= MODULE_SYMBOL_PREFIX #name;    			\
	static const struct kernel_symbol __ksymtab_##name	\
	__attribute_used__					\
	__attribute__((section("__ksymtab"), unused))	\
	= { (unsigned long)&sym, __kstrtab_##name }

Note, PPC64 still needs the dot hack because it changes the name of
*every* function symbol.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

