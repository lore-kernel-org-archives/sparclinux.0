From: Ben Collins <bcollins@debian.org>
Date: Tue, 04 May 2004 14:04:58 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504140458.GG3647@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Maybe it's just me, but the original version seems more readable, even
if it isn't proper formatting.

> -	sparc_cpu_model = sun_unknown;
> -	if(!strcmp(&cputypval,"sun4 ")) { sparc_cpu_model=sun4; }
> -	if(!strcmp(&cputypval,"sun4c")) { sparc_cpu_model=sun4c; }
> -	if(!strcmp(&cputypval,"sun4m")) { sparc_cpu_model=sun4m; }
> -	if(!strcmp(&cputypval,"sun4s")) { sparc_cpu_model=sun4m; }  /* CP-1200 with PROM 2.30 -E */
> -	if(!strcmp(&cputypval,"sun4d")) { sparc_cpu_model=sun4d; }
> -	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=sun4e; }
> -	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=sun4u; }
> +	if (!strcmp(&cputypval,"sun4 ")) {
> +		sparc_cpu_model=sun4;
> +	} else if (!strcmp(&cputypval,"sun4c")) {
> +		sparc_cpu_model=sun4c;
> +	} else if (!strcmp(&cputypval,"sun4m")) {
> +		sparc_cpu_model=sun4m;
> +	} else if (!strcmp(&cputypval,"sun4s")) {
> +		sparc_cpu_model=sun4m;	 /* CP-1200 with PROM 2.30 -E */
> +	} else if (!strcmp(&cputypval,"sun4d")) {
> +		sparc_cpu_model=sun4d;
> +	} else if (!strcmp(&cputypval,"sun4e")) {
> +		sparc_cpu_model=sun4e;
> +	} else if (!strcmp(&cputypval,"sun4u")) {
> +		sparc_cpu_model=sun4u;
> +	} else {
> +		sparc_cpu_model = sun_unknown;
> +	}

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
