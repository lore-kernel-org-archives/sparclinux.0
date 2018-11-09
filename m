From: Rob Herring <robh@kernel.org>
Date: Fri, 09 Nov 2018 20:30:01 +0000
Subject: Re: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
Message-Id: <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-1-robh@kernel.org> <20181107223151.14991-3-robh@kernel.org>
 <20181108.191116.1317160901826988583.davem@davemloft.net>
In-Reply-To: <20181108.191116.1317160901826988583.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Thu, Nov 8, 2018 at 9:11 PM David Miller <davem@davemloft.net> wrote:
>
> From: Rob Herring <robh@kernel.org>
> Date: Wed,  7 Nov 2018 16:31:45 -0600
>
> > @@ -32,24 +32,7 @@ unsigned int of_pdt_unique_id __initdata;
> >
> >  static char * __init of_pdt_build_full_name(struct device_node *dp)
> >  {
> > -     int len, ourlen, plen;
> > -     char *n;
> > -
> > -     dp->path_component_name = build_path_component(dp);
> > -
> > -     plen = strlen(dp->parent->full_name);
> > -     ourlen = strlen(dp->path_component_name);
> > -     len = ourlen + plen + 2;
> > -
> > -     n = prom_early_alloc(len);
> > -     strcpy(n, dp->parent->full_name);
> > -     if (!of_node_is_root(dp->parent)) {
> > -             strcpy(n + plen, "/");
> > -             plen++;
> > -     }
> > -     strcpy(n + plen, dp->path_component_name);
> > -
> > -     return n;
> > +     return build_path_component(dp);
> >  }
> >
> >  #else /* CONFIG_SPARC */
>
> Hmmm, shouldn't this be doing what the non-SPARC version of
> of_pdt_build_full_name() does which is to return the component string
> appended to the parent's full_name?
>
> You're just returning the component string here.

That is the intent. With this change we stop storing the full path for
every node. Everywhere that needs the full path, generates it with the
%pOF printf specifier. Other than users in arch/sparc converted in
this series all the users of full_name have been converted already or
use kbasename(full_name) so they work either way. BTW, I've found a
couple more, so I'll be sending you a v2.

And of_pdt_build_full_name for !SPARC does need to be converted too,
but I'll do that separately.

Rob
