From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Fri, 28 Jul 2017 08:45:15 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <22906.63899.54749.700924@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
References: <22906.17109.563338.559874@gargle.gargle.HOWL>
        <20170727.221009.2117810548718510128.davem@davemloft.net>
In-Reply-To: <20170727.221009.2117810548718510128.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpelinux@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpelinux@gmail.com>
 > Date: Thu, 27 Jul 2017 21:45:25 +0200
 > 
 > > Attempting to build strace-4.18 as sparcv9 code and run its test suite
 > > on a sparc64 machine (Sun Blade 2500 w/ 2 x USIIIi in my case) fails
 > > reliably in three test cases (sched.gen, sched_xetattr.gen, and poll)
 > > because two test binaries (sched_xetattr and poll) OOPS the kernel and
 > > get killed.  Sample dmesg from 4.13-rc2:
 > > 
 > > [42912.270398] Unable to handle kernel NULL pointer dereference
 > > [42912.327717] tsk->{mm,active_mm}->context = 000000000000136a
 > > [42912.383789] tsk->{mm,active_mm}->pgd = fff0000227db4000
 > > [42912.435247]               \|/ ____ \|/
 > >                              "@'/ .. \`@"
 > >                              /_| \__/ |_\
 > >                                 \__U_/
 > > [42912.559982] sched_xetattr(21866): Oops [#1]
 > > [42912.597773] CPU: 0 PID: 21866 Comm: sched_xetattr Not tainted 4.13.0-rc2 #1
 > > [42912.672138] task: fff0000229a5c380 task.stack: fff0000227dec000
 > > [42912.732876] TSTATE: 0000004411001603 TPC: 00000000007570fc TNPC: 0000000000757110 Y: 00000000    Not tainted
 > > [42912.845079] TPC: <__bzero+0x20/0xc0>
 > > [42912.874870] g0: 0000000000000000 g1: 0000000000000000 g2: 0000003000000000 g3: 00000000008ca100
 > > [42912.972120] g4: fff0000229a5c380 g5: fff000023ef44000 g6: fff0000227dec000 g7: 0000000000000030
 > > [42913.069446] o0: 0000000000000030 o1: fff0000227defe70 o2: 0000000000000000 o3: 0000000000000030
 > > [42913.166765] o4: fff0000227defe70 o5: 0000000000000000 sp: fff0000227def5c1 ret_pc: 0000000000474fa4
 > > [42913.268664] RPC: <SyS_sched_setattr+0xb0/0x150>
 > 
 > This looks really strange.  It is a memset() call with the buffer pointer
 > and length arguments reversed.
 > 
 > What exact command did you give to configure and build strace-4.18 so that
 > I can try to reproduce this?

It's an rpmbuild --rebuild of Fedora's strace-4.18-1.fc24.src.rpm, but according to the
build log the following should do it:

export CFLAGS='-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -grecord-gcc-switches  -m32 -mcpu=ultrasparc'
./configure --build=sparcv9-unknown-linux-gnu --host=sparcv9-unknown-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/u
sr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/libexec --local
statedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info
make -j2
make -j2 -k check VERBOSE=1


/Mikael
