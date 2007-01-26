From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 26 Jan 2007 23:17:02 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <1169853422.4809.35.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2007-01-27 at 00:12 +0100, Jan Engelhardt wrote:
> >On Fri, 2007-01-26 at 16:05 -0600, Tom 'spot' Callaway wrote:
> >> On Sun, 2007-01-21 at 17:25 +0200, Meelis Roos wrote:
> >> > TS> Warning: unable to open an initial console.
> >> > 
> >> > Try to use network console if the native console is not supported.
> >> > netconsole=..., see Documentation/networking/netconsole.txt
> >> 
> >> It was a good idea, but unfortunately:
> >> 
> >> eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c8 
> >> eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:c9 
> >> eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:ca 
> >> eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:b7:8f:cb 
> >> netconsole: eth0 doesn't support polling, aborting.
> >> 
> >> Yes, I have an e10k too. :)
> >
> >Even when I mount a valid root over NFS, the kernel always says: 
> >Warning: unable to open an initial console.
> 
> 
> >VFS: Mounted root (nfs filesystem) readonly.
> >Warning: unable to open an initial console.
> 
> Create /dev/console as char(5,1) on the root fs.

Already existed:

[root@odyssey gdb]# ls -l dev/console
crw--w---- 1 root tty 5, 1 Jan 25 10:33 dev/console

~spot

