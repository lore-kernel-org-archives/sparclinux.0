From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 27 Jan 2007 00:39:59 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169858399.4809.49.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2007-01-26 at 17:17 -0600, Tom 'spot' Callaway wrote:
> On Sat, 2007-01-27 at 00:12 +0100, Jan Engelhardt wrote:
> > >On Fri, 2007-01-26 at 16:05 -0600, Tom 'spot' Callaway wrote:
> > >> On Sun, 2007-01-21 at 17:25 +0200, Meelis Roos wrote:
> > >> > TS> Warning: unable to open an initial console.
> > >> > 
> > >> > Try to use network console if the native console is not supported.
> > >> > netconsole=..., see Documentation/networking/netconsole.txt
> > >> 
> > >> It was a good idea, but unfortunately:
> > >> 
> > >> eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c8 
> > >> eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c9 
> > >> eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:ca 
> > >> eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:cb 
> > >> netconsole: eth0 doesn't support polling, aborting.
> > >> 
> > >> Yes, I have an e10k too. :)
> > >
> > >Even when I mount a valid root over NFS, the kernel always says: 
> > >Warning: unable to open an initial console.
> > 
> > 
> > >VFS: Mounted root (nfs filesystem) readonly.
> > >Warning: unable to open an initial console.
> > 
> > Create /dev/console as char(5,1) on the root fs.
> 
> Already existed:
> 
> [root@odyssey gdb]# ls -l dev/console
> crw--w---- 1 root tty 5, 1 Jan 25 10:33 dev/console

Also tried mounting the nfsroot rw, but still:

TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr.15.36.9, mask%5.255.255.0, gw.15.36.254,
     host=spot1, domain=, nis-domain=(none),
     bootserver.15.36.3, rootserver.15.36.3, rootpathLooking up port of RPC 100003/2 on 10.15.36.3
Looking up port of RPC 100005/1 on 10.15.36.3
VFS: Mounted root (nfs filesystem).
Warning: unable to open an initial console.
eth0: Link is up using internal transceiver at 10Mb/s, Half Duplex.
eth0: Happy Meal out of receive descriptors, packet dropped.
eth0: Happy Meal out of receive descriptors, packet dropped.

Looking at init/main.c:

if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
   printk(KERN_WARNING "Warning: unable to open an initial console.\n");

... so, if root is mounted (over nfs), and root is mounted rw,
and /dev/console exists on the nfsroot, and it has rw permissions (I
gave it chmod 777 to just be sure), why would that sys_open call fail
and trigger that printk?

~spot

