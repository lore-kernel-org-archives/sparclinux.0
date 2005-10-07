From: Pasi Pirhonen <upi@iki.fi>
Date: Fri, 07 Oct 2005 18:22:25 +0000
Subject: Re: TILO
Message-Id: <20051007182225.GB28286@core.upi.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20051007111932.GA28286@core.upi.iki.fi>
In-Reply-To: <20051007111932.GA28286@core.upi.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Fri, Oct 07, 2005 at 10:03:11AM -0700, Ben Collins wrote:
> What happens when you load these via "boot net"?

> > Below is example of process, which does load, but usually die with
> > 'Illegal Instruction'. I think i saw 'MMU missmatch' or something
once
> > on Netra/X1.

So generally it's 'Illegal Instruction'. I did get once a different
meaage and i do believe it was 'MMU mismatch'.

I did peek a little 'debian side' and saw their 'spec' forcing gcc295
usage. I don't know if the compiler has anythning to do with this, but
it's

[root@x1 ~]# gcc -v
Reading specs from /usr/lib/gcc/sparc64-redhat-linux/3.4.4/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--disable-checking --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-java-awt=gtk
--host=sparc64-redhat-linux --build=sparc64-redhat-linux
--target=sparc64-redhat-linux --with-cpu=v7
Thread model: posix
gcc version 3.4.4 20050721 (Red Hat 3.4.4-2sp)

[root@x1 ~]# rpm -q silo
silo-1.4.9-1


I am just lost with this as this is very first time i ever try to
generate anything installable on sparc :)



> 
> On Fri, Oct 07, 2005 at 02:19:32PM +0300, Pasi Pirhonen wrote:
> > Hi,
> > 
> > 
> > I don't know if someone of you already know, but i've been working on
> > target named: CentOS-4/sparc. 
> > 
> > I hjaev been collecting/merging patches, building, testting, building
> > again past two or so months maybe. Finally having my vacation and time
> > to work full time with the problem
> > 
> > I did try generate installation images few day ago and realized that i
> > can't make working TILO-images with anything. Tried even extracting the
> > tools from Aurora 1.0 to my running system (which made a little diff.
> > sized images), but those are not booting.
> > 
> > Is there some magic i am not avare of and should that TILO just handle
> > 2.6 kernel allright?
> > 
> > Personally i don't see any point making public a distro that can't be
> > installed with 'boot net'.
> > 
> > Below is example of process, which does load, but usually die with
> > 'Illegal Instruction'. I think i saw 'MMU missmatch' or something once
> > on Netra/X1.
> > 
> > [root@c4sp sparc]# tilo -o test.img vmlinuz-2.6.9-22.EC-UNSTRIPPED
> > initrd64.img 
> > Converting vmlinuz-2.6.9-22.EC-UNSTRIPPED (sun4u) to a.out:
> > PT 0 Entry: Loadable to 0x400000[0x3335d0] from 0x0[0x2c6086] align
> > 0x100000
> > PT 1 Entry: unknown
> > Compressing vmlinuz-2.6.9-22.EC-UNSTRIPPED.raw:
> > vmlinuz-2.6.9-22.EC-UNSTRIPPED.raw:      54.5%
> > Sizes (sun4u):
> >   raw size     = 2891910
> >   packed size  = 1316731
> >   root address = 00000000007335d0
> > Root image packed size = 2052036
> > WARNING: Kernel for Sun4c/m/d not specified
> > Images are large. Will load on machines with at least 5M mapped by PROM
> > only
> > TILO size = 3385579
> > 
> > 
> > 
> > TIA,
> > 
> > 
> > -- 
> > Pasi Pirhonen - upi@iki.fi - http://iki.fi/upi/
> > -
> > To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Ubuntu     - http://www.ubuntu.com/
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> SwissDisk  - http://www.swissdisk.com/
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Pasi Pirhonen - upi@iki.fi - http://iki.fi/upi/
