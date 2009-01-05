From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 20:36:46 +0000
Subject: Re: kill most of sparc_ksyms*
Message-Id: <20090105203646.GA16865@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105194431.GA4976@uranus.ravnborg.org>
In-Reply-To: <20090105194431.GA4976@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 05, 2009 at 08:44:31PM +0100, Sam Ravnborg wrote:
> I gave Julian the receipe but he has focus on the prom_ stuff,
> so I decided to give it a spin.
> 
> I ended up with three largish patches. I could have made them
> smaller but this is trivial stuff so I could not see
> any real benefit doing so.
> Agreed that review would be easier but I hope this is OK.
> 
> I left the prom* stuff in the files to avoid to much
> conflict with Julian's ongoing work.
> When Julian has done the prom* stuff we should merge
> the two sparc_ksyms_*.c files to a single ksyms.c file.
> 
> Note the I decided to create a new file in
> arch/sparc/lib to hold the exported symbols in that directory.
> This is not common practice today but IMO better to
> have the EXPORT in same dir as the definition of the symbol.

Disregard this serie. I bug sneaked in on sparc64.
I will resubmit later this week.

	Sam
