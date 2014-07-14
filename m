From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 Jul 2014 06:11:33 +0000
Subject: Re: SILO on Qemu Sparc v8 unable to boot stripped kernel
Message-Id: <20140714061133.GA29068@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
In-Reply-To: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jul 13, 2014 at 09:08:47PM -0400, chase rayfield wrote:
> I sorted out the remaining issues and you can now download the first
> working version I have produced links below. Only tested in QEMU so
> far due to lack of time since I started my new job.
> 
> This is using Glibc 2.17, GCC 4.5.4, Binutils 2.21.1 and Linux
> 2.6.32-r41 (Gentoo revision 41) all the packages are at the latest
> stable revision otherwise. I may add a version that includes more
> things to demo and such to make testing sparc32 convenient in QEMU or
> real hardware.
> 
> http://www.gh0stwriter.net/gentoo/
> 
> http://www.gh0stwriter.net/archive/install-sparc-minimal-20140620.iso

Thanks for providing these.
Can you find time to tell what the issues was - so others can avoid the same.
Even if it was some stupid thing others could fail into the same.

	Sam
