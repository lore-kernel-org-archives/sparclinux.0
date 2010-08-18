From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 18 Aug 2010 21:26:22 +0000
Subject: Re: XVR-600 console not working with e3d
Message-Id: <20100818212622.GA8750@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.144843.104046744.davem@davemloft.net>
In-Reply-To: <20100817.144843.104046744.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Aug 18, 2010 at 01:11:50PM -0700, David Miller wrote:
> >> Probably missing a patch to the driver or similar.
> >=20
> > What's the revision of the file you built into xvr600_test.img,
> > so that I can compare?
>=20
> I have no idea, it was half a year ago.
>=20
> Just compare drivers/video/sunxvr500.c in current mainline with
> whatever is in your tree.

That's what troubles me. Our changelog says 2.6.32.18. That's:

http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.32.y.git;a=3Dh=
istory;f=3Ddrivers/video/sunxvr500.c;hLd50497264d3c65d092e1ca9c4fd55d2a7d0e=
22;hb=E8abf660c9744247c6d542070a50835adae399df

Whereas mainline is:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dhist=
ory;f=3Ddrivers/video/sunxvr500.c;h=B9c2b948d34d515b4cdccaa6c70d5ab1da29e06=
3;hb=3DHEAD

The substantial difference is bdd32ce95f79fb5cc964cd789d7ae4500bba7c6f.
If so, can you send it to stable@kernel.org please?

--=20
     2. That which causes joy or happiness.
