From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 23 Nov 2016 10:31:51 +0000
Subject: Re: 4.9.0-rc6-00086-g3b404a5 seems good on my sparc64 machines
Message-Id: <e23e6f4c-0d39-4248-fe28-370288c65680@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/23/2016 12:05 PM, Meelis Roos wrote:
> I tried yesterdays git 4.9.0-rc6-00086-g3b404a5 on most of my sparc64 
> machines and found no new regressions. The tests were only simple bootup 
> tests so far (no dist-upgrade since my userspace is stuck in debian 
> unstable 2015).

You should be able to dist-upgrade your 2015 unstable to a current version
of unstable without any bigger issues. You are effectively upgrading from
release to release+1 which is normally always supported.

Please post any issues to the debian-sparc mailing list.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
