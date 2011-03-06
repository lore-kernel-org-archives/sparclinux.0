From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 06 Mar 2011 20:49:45 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTinXjQcZkSZqDfjYJRzefZHWX5Zpauc9F1HE8RfK@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Mar 6, 2011 at 23:58, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> If you could send me your tips for building tftpboot images and stuff,
>> it'd save me some time.
>
> The userspace stuff I have is built with buildroot.
> I used the attached configuration.
>
> When building the kernel I use:
>
> ROOTFS=3D/path/to/buildroot.git/output/images/rootfs.ext2
> make ROOT_IMG=3D${ROOTFS} ARCH=3Dsparc tftpboot.img

Cool, thanks - I haven't fiddled around with buildroot yet.

> I then copy the final tftpboot.img to /var/lib/tftpboot/
> as C0A800C8.SUN4M - this is the filename my sun4m box ask for.
> I used tcpdump to check the name it requested.
>
> I have rarp so my /etc/ethers define
> the relation between mac and IP like this:
>
> 08:00:20:05:38:d2 =A0 =A0 =A0 192.168.0.200
>
>
> Initially my rarpd did not work.
> I had to add following options:
>
> # Do not check /tftpbootdir before response
> OPTIONS=3D"-v -e"
>
> Until I realized this I uses
>
> prom> boot net gateway-ip,,sun-ip
>
> But it is much more convinient with rarp as I can then type "boot net".
> And this is also default so I just turn on the box to boot it.

I'm all over tftpboot and rarp - I use tftp / rarp to install these boxes.

I'll have a go when I get home tonight, and hopefully have some sort
of result tomorrow.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
