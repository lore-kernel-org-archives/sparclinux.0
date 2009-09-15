From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 15 Sep 2009 19:38:22 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090915193822.GA4921@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Sep 15, 2009 at 12:03:06PM +0200, Josip Rodin wrote:
> On Tue, Sep 15, 2009 at 03:01:29AM -0700, David Miller wrote:
> > From: Josip Rodin <joy@entuzijast.net>
> > Date: Tue, 15 Sep 2009 11:58:33 +0200
> > 
> > > If the PROM console driver still has some utility, maybe the boot option is
> > > the way to go... does it? Does anyone still manufacture new machines with
> > > new and strange console types that we don't support? :)
> > 
> > The PROM console driver has no relevance today at all.
> > 
> > It should simply never be used.
> 
> OK, cool, please remove it, and also please propagate that to the stable
> branches so we don't miss anyone who's not on the bleeding edge.

Please feel free to follow up on http://bugs.debian.org/525958 which I've
filed in April to have the CONFIG_PROM_CONSOLE removed.

> 
> -- 
>      2. That which causes joy or happiness.
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-sparc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
