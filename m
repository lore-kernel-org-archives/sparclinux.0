From: David Miller <davem@davemloft.net>
Date: Wed, 13 Feb 2008 09:05:50 +0000
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
Message-Id: <20080213.010550.211671868.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080213.004120.22092044.davem@davemloft.net>
	<20080213085735.GB8091@uranus.ravnborg.org>
In-Reply-To: <20080213085735.GB8091@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 13 Feb 2008 09:57:35 +0100

> Review had been easier if the patch was inlined.

Sorry :)

> Can we plase have this changed to use:
> 
>  config SPARC64
> +	select HAVE_LMB
> 
> And then in lib/Kconfig have
> +config HAVE_LMB
> +	bool
> 
> So we avoid creating a new variable each time we introdce LMB support.
> You would need to update powerpc Kconfig too of course.

Sure, I'll rework this in the next day or so to do things
that way.

Thanks for the review.
