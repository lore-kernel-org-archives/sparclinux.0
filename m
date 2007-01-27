From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 27 Jan 2007 16:31:31 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169915491.4809.92.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2007-01-27 at 17:05 +0100, Jan Engelhardt wrote:
> On Jan 27 2007 09:37, Tom 'spot' Callaway wrote:
> >> 
> >> int ret = sys_open((const char __user *)"/dev/console", O_RDWR, 0);
> >> if(ret < 0)
> >>   printk(KERN_WARNING "Warning: unable to open an "
> >>          "initial console (%d)\n", ret);
> >> 
> >> I wonder what return code it will give (-EFAULT is my guess).
> >
> >Warning: unable to open an initial console (-2)
> >
> >-ENOENT ?
> >
> >/dev/console is definitely inside the nfsroot that I'm mounting...
> 
> 
> In case you are using initramfs/initrd, make it available there too.

I'm not. Everything is compiled in. I'm running make image, then
elftoaout arch/sparc64/boot/image, and booting the a.out kernel over
tftp.

~spot

