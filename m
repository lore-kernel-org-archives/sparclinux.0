From: Chris Newport <crn@netunix.com>
Date: Thu, 13 Sep 2007 12:14:59 +0000
Subject: Re: Is Sun putting much effort into supporting the gcc/binutils toolchain
Message-Id: <46E929C3.3090008@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46E7CF5F.3090909@walrond.org>
In-Reply-To: <46E7CF5F.3090909@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sunil Amitkumar Janki wrote:

>
> GCC for SPARC is a front end to this compiler, which isn't available
> for Linux/SPARC so not really useful at all. If Sun Studio were available
> for GNU/Linux SPARC this front end would probably function the same as
> on Solaris, maybe even without any changes at all.
>
> I don't know if the source code to this front end has been released in 
> the
> open or if it is even useful to the GCC project in general and to 
> GNU/Linux
> on SPARC in particular.
>
gcc and the GNU toolchain for Solaris can be found at 
http://www.sunfreeware.com/ which is sponsored by Sun.

This contains all of the hardware related stuff, so it should not be
difficult to recompile for sparclinux.  All under GPL of course.

