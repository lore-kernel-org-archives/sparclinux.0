From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sun, 17 May 2020 15:01:23 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200517150123.sl36ug27gwnyz6gf@wittgenstein>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
 <20200512.130633.293867428547074800.davem@davemloft.net>
In-Reply-To: <20200512.130633.293867428547074800.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, May 12, 2020 at 01:06:33PM -0700, David Miller wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Tue, 12 May 2020 19:15:24 +0200
>=20
> > I've tested this series with qemu-system-sparc64 and a Debian Sid image
> > and it comes up no problem (Here's a little recording
> > https://asciinema.org/a/329510 ).
>=20
> Can you show how you put this environment together and also what
> compilation tools you used?  Looks great.

Sorry for the delay. That mail somehow got lost in my inbox.

So in general, I used qemu-system-sparc64 which is available in Universe
with either Debian or Ubuntu and that's what I've been using as host
distro. So you need a=20

deb http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name> universe
deb http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe
deb-src http://us.archive.ubuntu.com/ubuntu/ <release-name>-updates universe

int /etc/apt/sources.list

So after this, you should be able to install

apt install qemu-system-sparc

Now we need an image and believe it or not there's a guy who lives in
Berlin too who builds Debian images for all crazy architectures. You can
download them from:

https://cdimage.debian.org/cdimage/ports/

They're built quite frequently. Sometimes you get unlucky because a new
kernel won't boot anymore then going a couple of months back usually
helps. So for this experiment I downloaded:

https://cdimage.debian.org/cdimage/ports/9.0/sparc64/iso-cd/debian-9.0-spar=
c64-NETINST-1.iso

then I did:

cd .local/share/qemu
truncate -s 15GB sparc64.img

And then to _install_:

qemu-system-sparc64 \
        -m 4096 \
  	-device virtio-blk-pci,bus=3DpciB,drive=3Dhd \
  	-drive file=3D/home/brauner/Downloads/debian-9.0-sparc64-NETINST-1.iso,f=
ormat=3Draw,if=3Dide,bus=3D1,unit=3D0,media=CDrom,readonly=3Don \
	-drive file=3D/home/brauner/.local/share/qemu/sparc64.img,format=3Draw,if=
=3Dnone,id=3Dhd \
	-boot order=3Dd \
        -net nic \
	-net user \
	-nographic \

Then the Debian install will run after it finishes you can boot with:

qemu-system-sparc64 \
	-name debian-unstable-sparc64 -machine sun4u,accel=3Dtcg,usb=3Doff -m 4096=
 \
	-smp 1,sockets=3D1,cores=3D1,threads=3D1 \
	-uuid ccd8b5c2-b8e4-4d5e-af19-9322cd8e55bf -rtc base=3Dutc -no-reboot -no-=
shutdown \
	-boot strict=3Don \
	-drive file=3D/home/brauner/.local/share/qemu/sparc64.img,if=3Dnone,id=3Dd=
rive-ide0-0-1,format=3Draw,cache=3Dnone,aio=3Dnative \
	-device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 \
	-msg timestamp=3Don -nographic

If the install isn't setting up the repos right and you can't install
stuff the correct url is:
http://ftp.ports.debian.org/debian-ports/
to put into sources.list

>=20
> > This is the sparc specific bit and _if_ you agree with the changes here
> > it'd be nice if I could get your review, and if technically correct,
> > your ack so I can fold this into a larger series and move on to the next
> > arch.
>=20
> With the delay slot instruction indentation fixed:
>=20
> Acked-by: David S. Miller <davem@davemloft.net>

Thank you, Dave!
Christian
