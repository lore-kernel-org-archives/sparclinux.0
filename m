From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 01 Feb 2009 22:43:41 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <20090201224341.GB30935@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 01, 2009 at 08:25:16PM +0100, Bastian Blank wrote:
> On Sun, Feb 01, 2009 at 10:00:29PM +0300, Alexey Dobriyan wrote:
> > generates 64-bit kernel, while earlier it generated 32-bit kernel.
> 
> This is in line with the other 32/64bit arches, s390 and powerpc. If
> you think this is a problem, you should bring that to the kbuild
> maintainers, because they need to find something then.


The sparc situation differs from x86.
For x86 we have three valid archs that we can specify: x86, i386 and x86_&4.
For sparc we have only two: sparc and sparc64.

And we really need to find a better way to create a 32 bit all*config.
I looked at it last time it was brought up - but I did not come up
with anything that I was really happy with.

	Sam
