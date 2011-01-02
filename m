From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 02 Jan 2011 00:31:48 +0000
Subject: Re: [PATCH 0/4] sparc: remove unused prom stuff
Message-Id: <AANLkTik6wqpLg65JMNaL+HyFmJ=juHAYO_h1FgPFXB-h@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110101225007.GA17611@merkur.ravnborg.org>
In-Reply-To: <20110101225007.GA17611@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 2, 2011 at 09:50, Sam Ravnborg <sam@ravnborg.org> wrote:
> There was a few patches recently that touched arch/sparc/prom/*
> This triggered me to look up why sparc and sparc64 differed
> so much in their low-level prom functions.
>
> And it was obvious that the older sparcs implementes the
> ROMVEC interface (I never found a spec for this).
> Where newer sparcs implements IEEE 1275.

I had vague plans to split this out into some form of ops structure,
but they never got off the ground - and it probably would have been
another layer of indirection that relatively slow sparcs might notice.
Though it'd give us a chance for proper openprom support for SUN3(X)
on m68k.

> While looking through the code I noticed that
> several functions/files was unused.
> I used "git grep" in the kernel tree to check - and
> I have sucessfully build a sparc kernel with
> the patches applied.

Looks good, for what it's worth.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
