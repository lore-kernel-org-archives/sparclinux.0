From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 29 Oct 2004 18:27:28 +0000
Subject: Re: Help re Frame Buffer/Console Problems
Message-Id: <20041029182728.GE12934@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:22:11PM +0100, Mark Fortescue wrote:
> I have been trying to get a CG3 sparc clone up and running with linux.
> Under 2.2.26, the console is fine. During the development of the
> 2.5.x/2.6.x frame buffer system the CG3 support got broken. I have managed
> to track done one of the problems (the blanking code had some typing
> errors in it) and this gave me a logo + black screen and cursor using a
> linux-2.2.8.1 kernel. Still no console text.
> Given that 2.2.10-rc1-bk6 is available, I have downloaded and applied the
> appropriate patches and made some additional mods to keep the
> compiler/linker happy. Now I have a black console, no text, logo or cursor
> and if I redirect the console output to a serial port I get the following:

Okay, sounds like a relatively major disaster. =(


-- wli
