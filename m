From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2017 20:35:49 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <20170821.133549.1817020810110297960.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170821.112747.1532639515902173100.davem@davemloft.net>
	<20170821183458.GA23205@lst.de>
	<alpine.LRH.2.20.1708212209280.31611@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1708212209280.31611@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mroos@linux.ee
Cc: hch@lst.de, helgaas@kernel.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, linux-kernel@vger.kernel.org

From: mroos@linux.ee
Date: Mon, 21 Aug 2017 22:20:22 +0300 (EEST)

>> I think with this patch from -rc6 the symptoms should be cured:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=C005390374957baacbc38eef96ea360559510aa7
>>=20
>> if that theory is right.
>=20
> The result with 4.13-rc6 is positive but mixed: the message about MSI-X=20
> affinty maks are still there but the rest of the detection works and the =

> driver is loaded successfully:

Is this an SMP system?

I ask because the commit log message indicates that this failure is
not expected to ever happen on SMP.

We really need to root cause this.
