From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Tue, 02 Nov 2004 23:19:04 +0000
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Message-Id: <200411030719.06138.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

On Wednesday 03 November 2004 06:57, Mark Fortescue wrote:
> Will this work for a kernel Panic ?
>

Probably not, unless the 'Panic' tells fbcon to release the console and 
tells promcon to take over the console again.  That in itself is problematic
as fbcon cannot be safely unloaded yet.

Tony


