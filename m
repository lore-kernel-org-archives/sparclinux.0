From: Jason Wever <weeve@gentoo.org>
Date: Wed, 22 Feb 2006 04:25:04 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060221212504.7ee91908@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_k+AJhCmmp_1LXwnr.moqt9t"
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

--Sig_k+AJhCmmp_1LXwnr.moqt9t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Feb 2006 19:59:50 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> I hate to say this Jason, but you're really bad at bug reporting.  You
> never do a thorough job and that's why your sparc64 bug reports either
> take an enormously long time to resolve or never get resolved at all.
>=20
> I did the Niagara port in one month because every time I had some
> weird bug to figure out I got all the necessary information and did
> all the necessary detective work in order to find the true cause of
> each and every problem.
>=20
> Whereas you always send me on wild goose chases with unrelated
> problems from your original report.  This __dequeue_signal
> local_bh_enable() bug message, totally unrelated to the ESP scsi crash
> you originally reported, is a good example of this.
>=20
> I hate to do this, pointing you out like this, but I want you to be
> able to do good bug reports.  Reports which I can solve in an
> afternoon, which is what is possible if you give me the right
> information.

Sorry about that :(

Thanks for taking the time to mention this though :)

Will post an update on the original bug when I have something.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_k+AJhCmmp_1LXwnr.moqt9t
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFD++egdKvgdVioq28RAn5mAKCYQEj2RbN59Ihy5nuAz3sDOisKEwCcC2mN
qRH2dKP6A61NqkpSP8S6z5E=
=MZFL
-----END PGP SIGNATURE-----

--Sig_k+AJhCmmp_1LXwnr.moqt9t--
