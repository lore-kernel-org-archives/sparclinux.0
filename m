From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 19:40:39 +0000
Subject: Re: [PATCH] fix warnings in psycho_common after ull conversion
Message-Id: <20090108194039.GA1308@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090108192723.GA27674@uranus.ravnborg.org>
In-Reply-To: <20090108192723.GA27674@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 08, 2009 at 11:34:37AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 8 Jan 2009 20:27:23 +0100
> 
> > This is due to different integer promotion in my 32 bit hosted gcc.
> 
> That's a bug.
> 
> C language promotion rules shouldn't change because
> the compiler is crossed from a 32-bit host to a 64-bit
> one.
> 
> I'll apply this, but I don't really know how much more of these
> gcc-3.4.x 32/64 cross compiler bug workarounds I can tolerate.

Understood and agreed on.

When I get time I will upgrade my working environment
and then I hope to find a solution so I can use a more sensible
toolchain as it seems my current setup is only causing problems.

	Sam
