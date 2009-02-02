From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 02 Feb 2009 05:48:23 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <20090202054823.GA2973@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 01, 2009 at 09:51:13PM +0000, Mark Fortescue wrote:
> Hi all.
> 
> Silly question. If ARCH=sparc is not 64bit then how do you make a 32bit 
> sparc kernel?

make arch=sparc menuconfig give you the option to select
if the kernel is 64 bit or not.

And this "64 bit?" option is what is causing us troubles for the
all*config targets.
allyesconfig and allmodconfig will both set this option to 'y'
so we cannot in any simple way generate a 32bit all{yes,mod}config.

	Sam
