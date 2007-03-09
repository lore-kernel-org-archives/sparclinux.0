From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 09 Mar 2007 20:44:02 +0000
Subject: Re: Dead lock with 2.6.20
Message-Id: <45F1C712.1050904@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <45F1C172.60103@systella.fr>
In-Reply-To: <45F1C172.60103@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl napsal(a):
>     Hello,
>=20
>     I have seen a very strange deadlock on a UltraSPARC 2 workstation (2 =

> UltraSPARC-II/296 MHz, 2048 MB, framebuffer Creator3D on UPA slot, 2 73=20
> GB SCA disks that form a raid1 array).
>=20
>     Hardware sounds good and I have tested it with SUNvts during two=20
> days without any failure.
>=20
>     This workstation is a mail server and runs with Debian/testing,=20
> kernel 2.6.20. It's a NIS and NFSv3/TCP clients. Its uptime was more=20
> than 9 days and it hangs without any message in the log, without panic=20
> and without oops. When it hangs, the queue of sendmail was about 3 GB=20
> due to a failure of a internet peering. I have rebooted the workstation=20
> (power button :-( ). You can find my .config at
>=20
> http://rayleigh.systella.fr/~bertrand/config-sun4u-2.6.20.gz
>=20
>     I don't know how debug this bug...
Hi,
do you have attached console ? Do you try STOP-A ? I have similar=20
problem on E450 tomorrow. After each second reboot system hang and I=20
can't STOP-A. Only power-off helps. System hang after udev insert sg=20
module. I disable udev  and this solve my problem.

			Dan





