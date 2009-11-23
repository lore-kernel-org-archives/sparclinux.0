From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 23 Nov 2009 22:40:28 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091123224028.GA30012@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 23, 2009 at 02:32:04PM -0800, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Mon, 23 Nov 2009 23:27:34 +0100
> 
> > On Mon, Nov 23, 2009 at 12:24:46PM -0800, David Miller wrote:
> >> From: Josip Rodin <joy@entuzijast.net>
> >> Date: Sat, 31 Oct 2009 17:48:06 +0100
> >> 
> >> > No idea, I got stuck there and reverted to .28. Then the machine started
> >> > exhibiting some other issues so it was reverted to .26. :/
> >> 
> >> Sorry for dropping the ball on this one.
> >> 
> >> As promised long ago, here is a 2.6.31.6 kernel built with you
> >> 2.6.31 config file.  Let me know if it exhibits the bootup problem
> >> so we can diagnose further:
> >> 
> >> 	http://vger.kernel.org/~davem/josip_test_2631_6.img
> >> 
> >> Thanks!
> > 
> > It works! Compiler issue?
> 
> Something like that.  It could also just be compiled "differently" by
> your gcc and expose some race or bug.

OK. Yours has gcc 4.2.4, and our ones have gcc 4.3.2 (that we shipped
as "stable" :)

I also just tried a newer packaged image, and it has the same issue.
It comes from the linux-image-2.6.30-bpo.2-sparc64-smp package,
which you can get from:

http://www.backports.org/debian/pool/main/l/linux-2.6/linux-image-2.6.30-bpo.2-sparc64-smp_2.6.30-8~bpo50+1_sparc.deb

To extract, use:

  dpkg-deb -x linux-image-2.6.30-bpo.2-sparc64-smp_2.6.30-8~bpo50+1_sparc.deb newdir

And then you have newdir/boot/vmlinuz-2.6.30-bpo.2-sparc64-smp etc

-- 
     2. That which causes joy or happiness.
