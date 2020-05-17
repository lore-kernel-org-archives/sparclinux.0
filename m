From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 May 2020 16:34:34 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <cfc07b63-29e6-cda9-c611-235e37970763@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
 <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
In-Reply-To: <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Christian Brauner <christian.brauner@ubuntu.com>, David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 17/05/2020 16:01, Christian Brauner wrote:

> On Tue, May 12, 2020 at 01:06:33PM -0700, David Miller wrote:
>> From: Christian Brauner <christian.brauner@ubuntu.com>
>> Date: Tue, 12 May 2020 19:15:24 +0200
>>
>>> I've tested this series with qemu-system-sparc64 and a Debian Sid image
>>> and it comes up no problem (Here's a little recording
>>> https://asciinema.org/a/329510 ).
>>
>> Can you show how you put this environment together and also what
>> compilation tools you used?  Looks great.
>=20
> Sorry for the delay. That mail somehow got lost in my inbox.
>=20
> So in general, I used qemu-system-sparc64 which is available in Universe
> with either Debian or Ubuntu and that's what I've been using as host
> distro. So you need a=20
>=20
> deb http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
> deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
> deb http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe
> deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates unive=
rse
>=20
> int /etc/apt/sources.list
>=20
> So after this, you should be able to install
>=20
> apt install qemu-system-sparc
>=20
> Now we need an image and believe it or not there's a guy who lives in
> Berlin too who builds Debian images for all crazy architectures. You can
> download them from:
>=20
> https://cdimage.debian.org/cdimage/ports/
>=20
> They're built quite frequently. Sometimes you get unlucky because a new
> kernel won't boot anymore then going a couple of months back usually
> helps. So for this experiment I downloaded:
>=20
> https://cdimage.debian.org/cdimage/ports/9.0/sparc64/iso-cd/debian-9.0-sp=
arc64-NETINST-1.iso
>=20
> then I did:
>=20
> cd .local/share/qemu
> truncate -s 15GB sparc64.img
>=20
> And then to _install_:
>=20
> qemu-system-sparc64 \
>         -m 4096 \
>   	-device virtio-blk-pci,bus=3DpciB,drive=3Dhd \
>   	-drive file=3D/home/brauner/Downloads/debian-9.0-sparc64-NETINST-1.iso=
,format=3Draw,if=3Dide,bus=3D1,unit=3D0,media=CDrom,readonly=3Don \
> 	-drive file=3D/home/brauner/.local/share/qemu/sparc64.img,format=3Draw,i=
f=3Dnone,id=3Dhd \
> 	-boot order=3Dd \
>         -net nic \
> 	-net user \
> 	-nographic \
>=20
> Then the Debian install will run after it finishes you can boot with:
>=20
> qemu-system-sparc64 \
> 	-name debian-unstable-sparc64 -machine sun4u,accel=3Dtcg,usb=3Doff -m 40=
96 \
> 	-smp 1,sockets=3D1,cores=3D1,threads=3D1 \
> 	-uuid ccd8b5c2-b8e4-4d5e-af19-9322cd8e55bf -rtc base=3Dutc -no-reboot -n=
o-shutdown \
> 	-boot strict=3Don \
> 	-drive file=3D/home/brauner/.local/share/qemu/sparc64.img,if=3Dnone,id=
=3Ddrive-ide0-0-1,format=3Draw,cache=3Dnone,aio=3Dnative \
> 	-device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1=
 \
> 	-msg timestamp=3Don -nographic
>=20
> If the install isn't setting up the repos right and you can't install
> stuff the correct url is:
> http://ftp.ports.debian.org/debian-ports/
> to put into sources.list

FWIW if you're running a more recent version of QEMU (>=3D3.1) then you can=
 also boot
from the virtio-blk-pci device directly instead of having to switch back to=
 the IDE
device after installation as you have done above. Should be something like:

qemu-system-sparc64 \
         -m 4096 \
   	-device virtio-blk-pci,bus=3DpciB,drive=3Dhd \
 	-drive
file=3D/home/brauner/.local/share/qemu/sparc64.img,format=3Draw,if=3Dnone,i=
d=3Dhd,bootindex=3D0 \
        -net nic \
 	-net user \
 	-nographic

Note the removal of the legacy -boot argument and the addition of "bootinde=
x=3D0" to
the -drive argument.


ATB,

Mark.
