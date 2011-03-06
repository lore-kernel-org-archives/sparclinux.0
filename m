From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sun, 06 Mar 2011 15:24:18 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq
Message-Id: <Pine.LNX.4.64.1103061619530.29345@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 6 Mar 2011, Sam Ravnborg wrote:
> > 
> > If you could send me your tips for building tftpboot images and stuff,
> > it'd save me some time.
> 
> The userspace stuff I have is built with buildroot.
> I used the attached configuration.
> 
> When building the kernel I use:
> 
> ROOTFS=/path/to/buildroot.git/output/images/rootfs.ext2
> make ROOT_IMG=${ROOTFS} ARCH=sparc tftpboot.img
> 
> I then copy the final tftpboot.img to /var/lib/tftpboot/
> as C0A800C8.SUN4M - this is the filename my sun4m box ask for.
> I used tcpdump to check the name it requested.
> 
> I have rarp so my /etc/ethers define 
> the relation between mac and IP like this:
> 
> 08:00:20:05:38:d2       192.168.0.200
> 
> 
> Initially my rarpd did not work.
> I had to add following options:
> 
> # Do not check /tftpbootdir before response
> OPTIONS="-v -e"
> 
> Until I realized this I uses
> 
> prom> boot net gateway-ip,,sun-ip
> 
> But it is much more convinient with rarp as I can then type "boot net".
> And this is also default so I just turn on the box to boot it.
> 
> 	Sam
> 

The C0A800C8.SUN4M string is generated based upon ip-address and 
architecture. The C0A800C8 is the IP address obtained by rarp translated to 
hex. (192 = C0. 168 = A8. 0 = 00. 200 = C8). 

Kjetil Oftedal
