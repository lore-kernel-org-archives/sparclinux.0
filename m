From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 15:21:57 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <alpine.LSU.2.01.0912221619480.27696@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2009-12-22 01:19, Dennis Gilmore wrote:
>On Monday 21 December 2009 06:06:26 pm Jan Engelhardt wrote:
>> 
>> RPM offers the targets sparcv9v/sparc64v (which is, simply put,
>> cflags += -mtune=niagara).
>> 
>> But how would the package manager (apt-get/yum/zypper) decide whether
>> they are on sun4v or not[...]
>
>yum does this by checking /proc/cpuinfo look at /usr/lib/python2.6/site-
>packages/rpmUtils/arch.py on a F-12 box  and search for sun4v  rpm has a 
>similar check based on the same information. both will refuse to install a 
>sparcv9v package on hardware that is not capable of running it.

As far as I can tell, sparcv9v packages are not created in an
sparcv9-incompatible way.

$ grep -r niagara /usr/lib/rpm
/usr/lib/rpm/rpmrc:optflags: sparcv9v -O2 -g -m32 -mtune=niagara
/usr/lib/rpm/rpmrc:optflags: sparc64v -O2 -g -m64 -mtune=niagara

It only uses -mtune, not -mcpu. Or did I err somewhere in this regard?



>
>Dennis
>

Jan
