From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 01 Dec 2009 21:42:12 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091201214211.GA6540@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 30, 2009 at 09:23:36PM -0800, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Mon, 23 Nov 2009 23:40:28 +0100
> 
> > http://www.backports.org/debian/pool/main/l/linux-2.6/linux-image-2.6.30-bpo.2-sparc64-smp_2.6.30-8~bpo50+1_sparc.deb
> > 
> > To extract, use:
> > 
> >   dpkg-deb -x linux-image-2.6.30-bpo.2-sparc64-smp_2.6.30-8~bpo50+1_sparc.deb newdir
> > 
> > And then you have newdir/boot/vmlinuz-2.6.30-bpo.2-sparc64-smp etc
> 
> I've tried everything to reproduce this.
> 
> I've tried building 2.6.31.6 -stable from Josip's config using
> Debian stable's compiler (gcc-4.3.2)

I think you need to build with the gcc from unstable to reproduce the failure.
Lenny kernels have been booting fine on my box (SunBlade 1000), unstable kernels
started failing about 3 months ago. I might have some time over the weekend to
build the current unstable kernel with both stable and unstable gcc to verify
that it's unstable gcc which causes problems.
 
> I've also tried the image in that dpkg.
> 
> All of them boot fine on my two similarly configured UltraSPARC-IIIi
> systems.
> 
> I'll try to think some more about this, but meanwhile if you have some
> means by which to make your V240 available to me online to do somet
> debugging that would be really useful.
> 
> You can see from Hermann's providing access to his V480 to me once I
> have access I tend to fix the bug within a day or two :-)
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-sparc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
