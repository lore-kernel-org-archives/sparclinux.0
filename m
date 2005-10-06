From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 13:21:20 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1128604880.2140.123.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2005-10-05 at 17:24 -0700, David S. Miller wrote:
> From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> Date: Wed, 05 Oct 2005 17:10:54 -0500
> 
> > 7caaeabb17758295edff9703c18a840073c5b8f4
> 
> This change should cause us to lookup ".[a-z]*" symbols
> as "_[A-Z]*", as per the change made in handle_modversions()
> in scripts/mod/modpost.c
> 
> So when a module references ".udiv" that symbol reference
> should get rewritten to "_Udiv" and that latter symbol is
> what we actually export from the kernel.
> 
> As best as I can tell, what is needed is similar logic in
> depmod.  Ie. something like:
> 
> + 			if (symname[0] = '.') {
> + 				char *munged = strdup(symname);
> + 				munged[0] = '_';
> + 				munged[1] = toupper(munged[1]);
> + 				symname = munged;
> + 			}
> 
> I see you just hardcoded the various ".*" symbol names Sparc
> uses in your patch.

My concern was the comment around the existing routine in the depmod
code:

/* For our purposes, .foo matches foo.  PPC64 needs this. */
        if (name[0] = '.')
                name++;

If PPC64 still needs this, we can't just munge to the _<upper> condition
universally, we still need some mechanism of identifying whether we want
the PPC64 behavior for dot symbols or the sparc32 behavior for dot
symbols. By hardcoding the six sparc specific symbols, and changing them
first, we ensure that the PPC64 case still works.

I can shorten it a little bit by doing:

        /* Handle the wacky sparc cases */
        if (strcmp(name, ".div") = 0) || (strcmp(name, ".udiv") = 0)
|| (strcmp(name, ".mul") = 0)
           (strcmp(name, ".umul") = 0) || (strcmp(name, ".rem") = 0)
|| (strcmp(name, ".urem") = 0) {
                char *munged = strdup(name);
                munged[0] = '_';
                toupper(munged[1]);
                name = munged;
        }

But we'd still have to hardcode the names.

Of course, all of this is moot if the PPC64 is munging their dot symbols
in the same way.

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

