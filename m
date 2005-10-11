From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 11 Oct 2005 10:03:36 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1129025016.8218.38.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2005-10-10 at 11:22 -0700, David S. Miller wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> Date: Mon, 10 Oct 2005 20:20:52 +1000
> 
> > #define __EXPORT_SPECIAL_SYMBOL(name, sym) \
> > 	static const char __kstrtab_##name[]			\
> > 	__attribute__((section("__ksymtab_strings")))		\
> > 	= MODULE_SYMBOL_PREFIX #name;    			\
> > 	static const struct kernel_symbol __ksymtab_##name	\
> > 	__attribute_used__					\
> > 	__attribute__((section("__ksymtab"), unused))	\
> > 	= { (unsigned long)&sym, __kstrtab_##name }
> > 
> > Note, PPC64 still needs the dot hack because it changes the name of
> > *every* function symbol.
> 
> The reason we did the ".foo" --> "_Foo" transformation was
> exactly because we didn't want to do crap like this any more.
> 
> It's error prone, and is nearly impossible to get working with
> every version of the compiler.
> 
> Why don't we just put an ifdef __sparc__ thing into modutils
> which understands the ".foo" --> "_Foo" translation?

Um.  We could do that.  It's not clear to me why putting it in modutils
will make it less "error prone" or portable.  Exporting symbol with
correct name need only be done in one place.  Mangling needs to be done
in three places (where it's exported, modprobe.c, and modutils).

The only reasons we can't export symbols like ".div" are (1) because the
export macros use the symbol names to build temporary unique variable
names.  This is merely an implementation detail in the EXPORT_SYMBOL
macro (we could use __LINE__ instead).

And (2) for PPC64, we put in the "ignore ." hack.  Everyone used to be
happy with that, so it wasn't made PPC64 specific.  In retrospect, that
was a mistake.

Look, I don't *actually* care.  Send me whatever hack patch you want for
sparc modutils.  Then wait for me to do a new module-init-tools release
to sync up.  Repeat every time you change your mind.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

