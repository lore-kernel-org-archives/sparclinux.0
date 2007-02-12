From: Daniel Smolik <marvin@mydatex.cz>
Date: Mon, 12 Feb 2007 08:08:26 +0000
Subject: Re: Odp: compile kernel for SS5 on E450
Message-Id: <45D0207A.4050004@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <45d01ce54a0c8@wp.pl>
In-Reply-To: <45d01ce54a0c8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Krzysztof Helt napsal(a):
>=20
> Dnia 10-02-2007 o godz. 22:40 Daniel Smolik napisa=B3(a):
>=20
>>WARNING: "floppy_hardint" [drivers/block/floppy.ko] undefined!
>>
>>Is it my fault or do I some wrong ?
>>
>=20
>=20
> AFAIK, you cannot compile the floppy as a module.
>=20
OK no problem :-) But what this ?


WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to=20
.init.text:qp                                           ti_map_regs from=20
.text between 'qpti_sbus_probe' (at offset 0x1b94) and 'qpti_sb

Is ti only warning or problem ?


		Regards
				Dan




