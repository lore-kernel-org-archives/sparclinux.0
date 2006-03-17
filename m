From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 17 Mar 2006 21:20:16 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <20060317.132016.117845021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Daniel 'NebuchadnezzaR' Dehennin <sparc@asgardr.info>
Date: Fri, 17 Mar 2006 19:28:15 +0100

> Le 4580 Septembre 1993, David S. Miller a tapot=E9:
> > Only if you can do the heavy lifting of building new kernels,
> > modifying the conditional, testing the result and sending
> > a working patch after the testing.
>=20
> Ok, I modify the test in bbc_i2c_init to include cheetah_plus:
> From dmesg:
>=20
> bbc: module license 'unspecified' taints kernel.
> EBUS i2c-0: Regs at 000007fe7e00002e, 6 devices, own a0, clock 10.
> i2c-1: Regs at 000007fe7e000030, 8 devices, own a0, clock 10.
> bbc_envctrl: kenvctrld starting...
>=20
> So it works, fan follow the cpu usage, is there a place to look at
> temperature and fans speed ?
>=20
> The module envctrl do not load: "no such device".

envctrl is for SME compact-pci CP1500 systems and similar.

bbc_envctrl just monitors the temperature and changes the
fan speeds automatically, it does not export the temp and
fan speed values in any way outside of the kernel

