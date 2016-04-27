From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 27 Apr 2016 15:16:19 +0000
Subject: Re: kernel boot broken since 4.5 on t5220 ( niagara2 ) machine
Message-Id: <20160427151619.GD5369@vapier.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BUkSJvRMivPPUEQV"
List-Id: <sparclinux.vger.kernel.org>
References: <57207083.1000703@alcatel-lucent.com>
In-Reply-To: <57207083.1000703@alcatel-lucent.com>
To: sparclinux@vger.kernel.org


--BUkSJvRMivPPUEQV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Apr 2016 14:28, Anatoly Pugachev wrote:
> On Wed, Apr 27, 2016 at 1:09 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Wed, Apr 27, 2016 at 09:55:47AM +0200, Joerg Abraham wrote:
> >> Hi,
> >>
> >> since kernel version 4.5 my t5220 does not boot anymore, small logs
> >> attached...
> >>
> >> bisecting the problem points to commit:
> >>
> >> 1a40b95374f680625318ab61d81958e949e0afe3
> >>
> >> or
> >>
> >> 1a40b95 (sparc: Fix system call tracing register handling.)
> >
> > Meelis Roos reported issues with the same commit.
> > See the thread "RED State Exception in 4.5 on E420R"
>=20
> Just to let you know guys, I have quite a similar hardware, not T5220,
> but T5120, and I don't have this issue, 4.5.x kernel works, 4.6.0
> boots (but OOPS with different trace, going to report it with another
> email).

i've been running v4.5 on a Sun Fire T200 for a while and haven't
noticed boot issues.  i do have some troubles under high loads and
cores locking up, but that isn't new to v4.5 :).
-mike

--BUkSJvRMivPPUEQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXINfCAAoJEEFjO5/oN/WBQtEP/2UAgqlbvGwIDh7WUsT7ir2Y
zNqHYMJas8ZgGwF3SwTur5CmwZDMa1Aiq5aqjkBpR8FV2XzLVAd2BE8TRl5/Sp5V
wIW6etPxFs7WlrLyWewE5RKFIklNkytRutka5MSy7zibGZFFldw3RYLKN2SZSWXr
b8DlR0+PBQURGfVQtUTIJzwQ0xmjATAgTnaJpAbGULChxcToay0IAzJmlwGfSpyU
7Qy8F2/0GxyGePcpjn8vuWAOxPi/0qK/hr4O80fOzYQSIbtRtHG/vTauvHH0xRPJ
6VD0s0sLrEncwsmDm76Jg2DiKm9DPeb1jzJX3lXqJI9nIXmpZUUFvf4rF878VDxl
szhy8rMbaYv2bQkTw9g6netnuY6mZ4UZdw3JuHdvmGdTjA8QGZBvQYCHVH5k2d7E
7Qp1jd71BnDTp7Z0jUxyCfWtQfXPjywlzVgLukLCoh1tvXpBwK0aCZ2ZlNfKXUs3
6COe/6NnbjhEkka3CR0I0MqIzoXrqzMvDdycKg3YcNXgXXOcXX+CPHuVKdS1a+Ob
vgDLuWoUuy4UyMf713MPj7ByXHIiFoBOjHy0CKNWwpCsIPubpxJV/kFyj6wmWmH2
OBSeKikm5FKnUAxDzPnofXH2af5rY7+smkkZCpAmMO5f1qdtVoxTfxVI8GQ1TAlb
0n6WRAW1ZpAYcfNiXXdi
=YFvM
-----END PGP SIGNATURE-----

--BUkSJvRMivPPUEQV--
