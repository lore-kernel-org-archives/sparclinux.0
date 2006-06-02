From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Fri, 02 Jun 2006 15:31:37 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap() (was Re: 2.6.17-rc3+git
Message-Id: <448059D9.3070404@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

> I'll also post a little reproducer program that can be used to
> accurately see if the patch really fixes the problem on your
> machine or not, which should help with the variability of the
> dpkg corruption case.
> 
> Please test this, I need to know if this works for everyone
> or not.

Works for me too on my u5.
On a side note it seems to have fixed the alsa oops i reported some time 
ago that's missing from the archives.
Basically listen to some ogg file with alsa output with ogg123 
(vorbis-tools), usually when it's finished or if you break it you'll get 
it nicely (at least with snd-sun-cs4231, i think ens1371 too but i have 
it out of my box atm).

-- 
Gustavo Zacarias
Gentoo/SPARC monkey
