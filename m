From: Bernd Zeimetz <bernd@bzed.de>
Date: Mon, 29 Oct 2007 01:18:30 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <472534E6.6020108@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Sorry, but if there would be an easy test case we'd be more than happy
and would present it - unfortunately there is not. This is more than
annoying for us all. But if this bug isn't fixed chances are good that
the next Debian release won't support Sparc at all.

> I have ubuntu gutsy on my SunFire280R, so I can debootstrap
> debian chroots or whatever is needed to trigger this.

You need a Blade 1000/2000 or v440/v880 or an enterprise class machine
to reproduce this more easily (still assuming that we're facing the same
bug here - at least the symptoms are the same). Those machines use
repeater chips as interconnect between two CPUs (and between pairs of
cpus for larger machines), according to my contact from Sun similar to
that what's implemented in one US IV cpu.
This explains why you have trouble to reproduce this, while Josip and me
get hit by this bug way too often.

On all other machines using cpus <= US III I have now idea how to
reproduce this easily - you just get hit by it after $random builds.
Don't have access to more recent hardware.

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
