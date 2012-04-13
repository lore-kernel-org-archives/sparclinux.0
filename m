From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 13 Apr 2012 09:55:33 +0000
Subject: Re: Question about hibernation on sparc64
Message-Id: <498741334310934@web83.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <80041334231315@web149.yandex.ru>
In-Reply-To: <80041334231315@web149.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


12.04.2012,=9A20:32,=9A"David=9AMiller"=9A<davem@davemloft.net>:
>=9AFrom:=9AKirill=9ATkhai=9A<tkhai@yandex.ru>
>=9ADate:=9AThu,=9A12=9AApr=9A2012=9A15:48:35=9A+0400
>
>>=9A=9ASo=9AI=9Awant=9Ato=9Aask=9Apeople=9Awho=9Aknow=9Asparc64=9Adeeply.=
=9AAre=9Athere=9Aany
>>=9A=9Aarchitecture=9Alimits=9Awhich=9Amake=9Ahibernation=9Aon=9Av9=9Aimpo=
ssible?=9AMay=9Abe
>>=9A=9Aanybody=9Ahas=9Aresearched=9Athis=9Aquestion.
>
>=9AI=9Acan't=9Athink=9Aof=9Aany=9Asparc64=9Ahardware=9Awhich=9Awould=9Asup=
port=9Ahibernation
>=9Ain=9Aany=9Areasonable=9Away,=9Aso=9AI'm=9Aquite=9Asurprised=9Athat=9Ayo=
u=9Aplan=9Aon
>=9Aimplementing=9Asupport=9Afor=9Ait.=9A=9APerhaps=9Ayou=9Acan=9Aelaborate=
=9Ayour=9Aplans=9A:-)

1)As=9AI=9Asee=9Ain=9ACONFIG_HIBERNATION=9Acomment:

"In=9Aprinciple=9Ait=9Adoes=9Anot=9Arequire=9AACPI=9Aor=9AAPM,=9Aalthough=
=9Afor=9Aexample=9AACPI=9Awill=9Abe=9Aused=9Afor=9Athe=9Afinal=9Asteps=9Awh=
en=9Ait=9Ais=9Aavailable".

And=9Ait's=9Aimplemented=9Aon=9Aplatforms=9Aw/o=9AACPI=9Alike=9AMIPS.

So=9Ait=9Aseems=9Ato=9Ame=9Athat=9Ait=9Adoesn't=9Arequire=9Aspecial=9Ahardw=
are=9Asupport,=9Abut=9Aexceptions=9Aare=9Apossible..

2)During=9Athe=9Asecond=9Aboot=9Ahibernation=9Adoes=9Athe=9Anormal=9Aboot=
=9A(it=9Ainitializes=9Ahardware in its normal way - standard initcalls).
The only exeption is "late_initcall(software_resume)" which resumes the mem=
ory, but it is executed after hardware is initialized.
---

We are talking about hibernation, it's different from "suspend to RAM" oper=
ation. "Suspend to RAM" requires hardware support.

Kirill
