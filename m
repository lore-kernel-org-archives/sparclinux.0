From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 12 Oct 2005 11:20:06 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <wrpfyr7j82h.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

>>>>> "Meelis" =3D Meelis Roos <mroos@linux.ee> writes:

Meelis> ..=C9.=A5=BD..2.86 booting
Meelis> Starting the hotplug events dispatcher: udevd.

Meelis> M.=A5=D1.=A1=A5...to runlevel: 6
Meelis> ..=A5...processes the TERM signal

Meelis> Is this known to corrupt sometimes or is it thought to be fixed?
Meelis> I'm running todays 2.6.14-rc4-gda64c6ee.

I've seen this kind of things for ages with sunsab. Looks like init
messes with the tty settings, and maybe it confuses the chip for a
while...=20

	M.
--=20
And if you don't know where you're going, any road will take you there...
