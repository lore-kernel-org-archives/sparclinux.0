From: Bernd Zeimetz <bernd@bzed.de>
Date: Mon, 29 Oct 2007 00:01:43 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <472522E7.6040304@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

> Since mono team decided that the mono is broken on Sparc (and despite
> the fix provided by David Miller), I had to rebuild after enabling the
> sparc
> arch in the source.
> 
> The hangs happens always at the end of the buid when invoking
> dh_shgenlibs in the build.
> 
> This is not 100% reproducable even in my env.

Trying this at the moment.

> Second was sun blade 2000 SMP with Ubuntu gutsy, I wasn't able to update
> the xemacs21 package.
> The machine hanged with invoking the post installation script.

Does the Blade run with one or two CPUs? If I remember right they
support to run with one CPU which has to be inserted in a special
slot/carrier for that. With two CPUs it should use the same repeater
chips and architecture as the v440, v880 and larger machines.


Cheers,

Bernd

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
