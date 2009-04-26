From: David Miller <davem@davemloft.net>
Date: Sun, 26 Apr 2009 01:12:51 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090425.181251.151134953.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: S=E9bastien Bernard <seb@frankengul.org>
Date: Sun, 26 Apr 2009 01:30:35 +0200

> sparc port is unofficial but available on the ports.ubuntu.com for all
> version up to 9.04.
> PPC has been retrogaded in ports recently since apple dropped that
> arch in favor of x86.
> The compiler is not custom. It came from the ubuntu archive.
> I don't think the compiler is the culprit in this case because all of
> the kernels built before 2.6.29 are working OK
> (I could be wrong, but it's unlikely).

I'm worryed with this particular bug because the NMI code added
in 2.6.29 where this bootup is hanging has a loop over a variable
changing, with a memory barrier in there.  It's exactly the kind
of thing a compiler error can and has caused in the past.

> I have a sid debian sparc available. I'll try to build a kernel with
> that compiler and try if it changes anything.

Thanks.
