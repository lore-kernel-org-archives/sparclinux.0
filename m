From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Mon, 31 Jul 2017 17:14:53 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <22911.25997.495345.538443@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
References: <22906.17109.563338.559874@gargle.gargle.HOWL>
        <20170727.221009.2117810548718510128.davem@davemloft.net>
        <22906.63899.54749.700924@gargle.gargle.HOWL>
        <CADxRZqzcDswmJA=nESkkqS7PFym4NGFxAXTUrFybzvx9ALdNfw@mail.gmail.com>
        <22908.31076.708982.410201@gargle.gargle.HOWL>
In-Reply-To: <22908.31076.708982.410201@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: Anatoly Pugachev <matorola@gmail.com>, David Miller <davem@davemloft.net>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

Mikael Pettersson writes:
 > Anatoly Pugachev writes:
 >  > On Fri, Jul 28, 2017 at 11:45 AM, Mikael Pettersson
 >  > <mikpelinux@gmail.com> wrote:
 >  > > It's an rpmbuild --rebuild of Fedora's strace-4.18-1.fc24.src.rpm, but according to the
 >  > > build log the following should do it:
 >  > >
 >  > > export CFLAGS='-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -grecord-gcc-switches  -m32 -mcpu=ultrasparc'
 >  > > ./configure --build=sparcv9-unknown-linux-gnu --host=sparcv9-unknown-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/u
 >  > > sr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/libexec --local
 >  > > statedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info
 >  > > make -j2
 >  > > make -j2 -k check VERBOSE=1
 >  > 
 >  > cant' reproduce it here on debian sparc64 LDOM:
 > 
 > DaveM was also unable to reproduce it.
 > 
 > I'll be investigating a possible kernel miscompile next.

I don't think it's a miscompile.

First I recompiled 4.13-rc2 with each of gcc-7, gcc-6, and gcc-5, each
bootstrapped and regtested from the head of the respective FSF GCC branch:
no change, kernel 4.11 works while kernels >= 4.12 OOPS.  So a miscompile
seems unlikely.

Then I ran a git bisect between v4.11 (good) and v4.12 (bad), booting
each kernel and trying the problematic strace test binaries.  That
identified the following as the first bad commit:

commit 31af2f36d50e3b9b2fb7f17aa430c11c91f946c4
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Mar 21 17:04:45 2017 -0400

    sparc: switch to RAW_COPY_USER
    
    ... and drop zeroing in sparc32.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

That touches the CPU model specific assembly code in arch/sparc/lib/ for
copy_{to,from}_user and changes how it's wired into the rest of the kernel.
There's different code for different UltraSPARC and Niagara generations,
so if there is a bug in e.g. the USIII code, you won't see it on Niagara.

Unfortunately I don't see anything obviously wrong in Al's patch...

/Mikael
