From: Jason Wever <weeve@gentoo.org>
Date: Wed, 22 Sep 2004 03:08:05 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <Pine.LNX.4.61.0409212105120.28580@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 21 Sep 2004, Jason Wever wrote:

> I've definitely seen this on 2.6 SMP on the Ultra 2 as well.  I'll try to
> test 2.6.9-rc2 on both machines tonight and see if I can still replicate.

OK the Ultra 2 is up and running so far.  I've got it generating some good 
loads and will keep beating up on it (sometimes it can take a day or so 
for me to see this).

However 2.6.9-rc2 on the Blade 100 stops at the point it would normally 
switch from the "Loading Linux..." prompt to the framebuffer.  I've tried 
letting it go but it doesn't seem to go anywhere as I never get any 
network connectivity.  Is there a way I can try to generate some 
semi-useful output here to help troubleshoot what is going on?

Thanks.
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUOyXdKvgdVioq28RAqMxAJ0UIQ9sLP3BjBmlbRhyoGQlh3c4XgCfbzRL
wiTmpJNkObURQ8pZiwR3gww=mWCR
-----END PGP SIGNATURE-----
