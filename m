From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 06 Oct 2005 00:24:15 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20051005.172415.44977490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 05 Oct 2005 17:10:54 -0500

> 7caaeabb17758295edff9703c18a840073c5b8f4

This change should cause us to lookup ".[a-z]*" symbols
as "_[A-Z]*", as per the change made in handle_modversions()
in scripts/mod/modpost.c

So when a module references ".udiv" that symbol reference
should get rewritten to "_Udiv" and that latter symbol is
what we actually export from the kernel.

As best as I can tell, what is needed is similar logic in
depmod.  Ie. something like:

+ 			if (symname[0] = '.') {
+ 				char *munged = strdup(symname);
+ 				munged[0] = '_';
+ 				munged[1] = toupper(munged[1]);
+ 				symname = munged;
+ 			}

I see you just hardcoded the various ".*" symbol names Sparc
uses in your patch.
