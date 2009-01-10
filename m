From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 10 Jan 2009 08:16:34 +0000
Subject: Re: sparc32 broke
Message-Id: <20090110081634.GA3371@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 09, 2009 at 11:35:24PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 10 Jan 2009 08:33:21 +0100
> 
> > The real fix should look like this:
> > 
> > #ifdef __arch64__
> > #define _NSIG_BPW       64
> > #else
> > #define _NSIG_BPW       64
> > #endif
> > 
> > This is required because this header is exported to userspace
> > where we do not have access to CONFIG_* symbols.
> 
> I assume you meant to use "32" in the #else branch :-)
Freudian attempt or similar...

I now did a re-review of the unified signal.h.
And I could not spot any other subtle differences.

	Sam
