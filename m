From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 04 May 2004 14:21:04 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504142104.GB23807@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 04, 2004 at 10:04:58AM -0400, Ben Collins wrote:
> Maybe it's just me, but the original version seems more readable, even
> if it isn't proper formatting.
> 
> > -	sparc_cpu_model = sun_unknown;
> > -	if(!strcmp(&cputypval,"sun4 ")) { sparc_cpu_model=sun4; }
> > -	if(!strcmp(&cputypval,"sun4c")) { sparc_cpu_model=sun4c; }
> > -	if(!strcmp(&cputypval,"sun4m")) { sparc_cpu_model=sun4m; }
> > -	if(!strcmp(&cputypval,"sun4s")) { sparc_cpu_model=sun4m; }  /* CP-1200 with PROM 2.30 -E */
> > -	if(!strcmp(&cputypval,"sun4d")) { sparc_cpu_model=sun4d; }
> > -	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=sun4e; }
> > -	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=sun4u; }
> > +	if (!strcmp(&cputypval,"sun4 ")) {
> > +		sparc_cpu_model=sun4;
> > +	} else if (!strcmp(&cputypval,"sun4c")) {
> > +		sparc_cpu_model=sun4c;
> > +	} else if (!strcmp(&cputypval,"sun4m")) {
> > +		sparc_cpu_model=sun4m;
> > +	} else if (!strcmp(&cputypval,"sun4s")) {
> > +		sparc_cpu_model=sun4m;	 /* CP-1200 with PROM 2.30 -E */
> > +	} else if (!strcmp(&cputypval,"sun4d")) {
> > +		sparc_cpu_model=sun4d;
> > +	} else if (!strcmp(&cputypval,"sun4e")) {
> > +		sparc_cpu_model=sun4e;
> > +	} else if (!strcmp(&cputypval,"sun4u")) {
> > +		sparc_cpu_model=sun4u;
> > +	} else {
> > +		sparc_cpu_model = sun_unknown;
> > +	}

I don't like the original because it keeps doing strcmp() tests more
times than necessary. That was my motivation in doing changing this bit
of code.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
