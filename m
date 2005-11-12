From: Jason Wever <weeve@gentoo.org>
Date: Sat, 12 Nov 2005 04:03:27 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051111210327.3974b5fb@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Fri__11_Nov_2005_21_03_27_-0700_wIX6KhQgU/.wDd6o"
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
To: sparclinux@vger.kernel.org

--Signature_Fri__11_Nov_2005_21_03_27_-0700_wIX6KhQgU/.wDd6o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Nov 2005 21:02:34 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> Anyone feeling dangerous? :-)
>=20
> Today I put together a patch for IRQ stack support.
> This allows using single pages for the thread_struct
> plus kernel stack allocation.
>=20
> I've run it for half of today on my workstation with
> no ill results so far.  But more testing would be really
> nice, so if you can give this patch a spin that would
> be great.

I've tried this patch against 2.6.14-git14 on a 2x750 Blade 1000.  When
I let the blade boot normally, it for some reason fails to mount the
root filesystem and dies with the following error;

kernel BUG at kernel/fork.c:731

If I try booting the same kernel with the -p argument, this doesn't
happen and the system boots as expected.  Will let the system run like
this and see how it goes.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Fri__11_Nov_2005_21_03_27_-0700_wIX6KhQgU/.wDd6o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdWmSdKvgdVioq28RAkmxAJ4yohkapoiHnJqTBy+veeULTE6KfACdGRgp
qaWxpbzOy/C7K4TzSfh9TeE=
=aw5b
-----END PGP SIGNATURE-----

--Signature_Fri__11_Nov_2005_21_03_27_-0700_wIX6KhQgU/.wDd6o--
