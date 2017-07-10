From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Jul 2017 11:48:46 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170710114846.GA23190@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jul 10, 2017 at 02:46:19PM +0300, Meelis Roos wrote:
> > > This is with Debian unstable 32-bit userland as of 2015 summer. It did 
> > > not happen with 4.12.
> > 
> > Did you also perform tests with a current 64-bit userland?
> 
> No, for the current test this is not relevant since if the breakage 
> happens with some userlan, it is kernel at fault.

Yes, but I think it's more interesting to perform such tests with
current and maintained userland software.

> I never tested it on older machines so far. I might have tried 
> installing on Blade 150 (I am not sure if it was sparc or sparc64) but 
> the install was hanging, and I have not finished with it as I suspected 
> the PSU that I had just replaced and I have had no time to to hardware 
> bisecting with Blade 100.

Debian sparc64 runs fine on my Sun Blade 100.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
