From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 May 2012 16:16:06 +0000
Subject: Re: Linux on sparc v7
Message-Id: <20120521161606.GA5733@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4FBA4DBC.9070609@gaisler.com>
In-Reply-To: <4FBA4DBC.9070609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 21, 2012 at 04:14:20PM +0200, Daniel Hellstrom wrote:
> Hello Dave,
>
> I am trying to catch up on what has been happening lately with the sparc 
> port. Have the latest patches removed support for SPARC V7 CPUs?

Yes. The sun4c were the only users of v7 so today we tell gcc to generate v8
code. This imply support for muldiv & friends.

From the sparc Makefile:

    KBUILD_CFLAGS  += -mcpu=v8


As a side-note - we require support for the "flush" instruction now.
I assume LEON support this.

> The LEON VHDL model supports both V7 and V8 CPUs,
> FPU and non-FPU in any combination.

I do not have any overview on the FPU side of things.

	Sam
