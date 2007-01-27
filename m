From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 27 Jan 2007 15:37:45 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169912265.4809.88.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2007-01-27 at 12:17 +0100, Jan Engelhardt wrote:
> >Looking at init/main.c:
> >
> >if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> >   printk(KERN_WARNING "Warning: unable to open an initial console.\n");
> 
> That looks almost like a bug :-/
> "/dev/console" will decay into a pointer to kernel space, but
> sys_open takes a userspace one. The __user annotation does not
> change that. Try adding this:
> 
> >... so, if root is mounted (over nfs), and root is mounted rw,
> >and /dev/console exists on the nfsroot, and it has rw permissions (I
> >gave it chmod 777 to just be sure), why would that sys_open call fail
> >and trigger that printk?
> 
> int ret = sys_open((const char __user *)"/dev/console", O_RDWR, 0);
> if(ret < 0)
>   printk(KERN_WARNING "Warning: unable to open an "
>          "initial console (%d)\n", ret);
> 
> I wonder what return code it will give (-EFAULT is my guess).

Warning: unable to open an initial console (-2)

-ENOENT ?

/dev/console is definitely inside the nfsroot that I'm mounting...

bash-3.1# ls -l /dev/console 
crwxrwxrwx 1 root tty 5, 1 Jan 25 11:33 /dev/console

~spot

