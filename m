From: Jason Wever <weeve@gentoo.org>
Date: Sat, 26 Jun 2004 23:25:24 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <Pine.LNX.4.58.0406261721370.5154@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 26 Jun 2004, David S. Miller wrote:

> Yes, the OSS layer does a lot of PC-centric stuff, better to
> stick with the ALSA drivers as I do watch over them for
> portability when changes are made.

On a side note, has cs4231 ever been at a point in the 2.5 or 2.6 kernels 
where it has been usable?  It'll compile, build and load fine at least for 
PCI systems (SBUS is hit and miss whether it'll build but that's more 
typically core ALSA components) but the audio produced is never  
understandable.  On PCI I have tried turning on all of the debugging 
options but it doesn't seem to generate any helpful errors.

Thanks,
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3gXmdKvgdVioq28RAqiAAJ4mHIPxGAwWh8DWeKSb2AFup+fszACdFPl9
4TAie6t4aH1gnqfdmX80svo=sqKP
-----END PGP SIGNATURE-----
