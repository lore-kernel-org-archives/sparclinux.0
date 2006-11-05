From: andrew@walrond.org
Date: Sun, 05 Nov 2006 22:15:40 +0000
Subject: Re: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061105221540.GA11406@pelagius.h-e-r-e-s-y.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
In-Reply-To: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 05, 2006 at 01:27:49PM -0800, David Miller wrote:
> 
> This should be easy to fix, thanks for the report.  I'll take
> a look.
> 

No problem. I'm happy to test patches, etc.

> 
> Only in 2.6.18 do these drivers even have MODULE loading device
> ID information, and nobody has done the userland components yet.
> 
> Ubuntu and Debian use a hack'ish script that automatically finds the
> correct SBUS modules by dumping the firmware device tree and looking
> for certain node names.  They have a simple file that has firmware
> node name to kernel module name mappings, which the bootup and
> installer infrastructure make use of.  I forget where all of this is,
> but I've tested it and it does work.
> 

Thanks for the info. I'll take a look at edgy and see what they have done.


Is anybody else running a pure 64bit distro? I am finding two of my
favourite tools, xemacs and gdb to be a tad flakey. Haven't done any
serious investigating yet, or reported any bugs. Just wondered if
anyone else has experienced this?

Andrew Walrond
