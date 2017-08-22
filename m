From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Aug 2017 05:02:00 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <alpine.LRH.2.20.1708220801450.31611@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20170821.112747.1532639515902173100.davem@davemloft.net> <20170821183458.GA23205@lst.de> <alpine.LRH.2.20.1708212209280.31611@math.ut.ee> <20170821.133549.1817020810110297960.davem@davemloft.net>
In-Reply-To: <20170821.133549.1817020810110297960.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: hch@lst.de, helgaas@kernel.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, linux-kernel@vger.kernel.org

>=20
> >> I think with this patch from -rc6 the symptoms should be cured:
> >>=20
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=C005390374957baacbc38eef96ea360559510aa7
> >>=20
> >> if that theory is right.
> >=20
> > The result with 4.13-rc6 is positive but mixed: the message about MSI-X=
=20
> > affinty maks are still there but the rest of the detection works and th=
e=20
> > driver is loaded successfully:
>=20
> Is this an SMP system?

Yes, T5120.

--=20
Meelis Roos (mroos@linux.ee)
