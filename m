From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jun 2006 06:09:04 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <20060602.230904.30184837.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Fri, 02 Jun 2006 12:31:37 -0300

> On a side note it seems to have fixed the alsa oops i reported some time 
> ago that's missing from the archives.
> Basically listen to some ogg file with alsa output with ogg123 
> (vorbis-tools), usually when it's finished or if you break it you'll get 
> it nicely (at least with snd-sun-cs4231, i think ens1371 too but i have 
> it out of my box atm).

Glad to hear it fixes other bugs :)

Thanks for testing.
