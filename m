From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 02 Nov 2007 16:21:06 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071102162106.GA31607@keid.carnet.hr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
To: sparclinux@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2007 at 09:55:44PM -0700, David Miller wrote:
> > I'm working on a kernel patch for 2.6.23 that will allow you to get
> > some useful debugging information in situations like this.
> >
> > I'll try to get you that patch by the end of tonight.
> 
> As promised, here is the patch below.
> echo "g" >/proc/sysrq-trigger
> 
> So when you get a stuck process or whatever, trigger this and
> send the output :-)

Great. Here you go, three of them, while the load was 3 and this process was
stuck:

buildd   10813  100  0.8 987368 17504 ?        RN   14:44 155:49 dpkg-query --search libpthread.so.0 libdl.so.2 libstdc++.so.6 libm.so.6 libgcc_s.so.1 libc.so.6 libFLAC.so.8 libid3tag.so.0 libz.so.1 libmad.so.0 libglib-2.0.so.0 libmikmod.so.2 libsndfile.so.1 libvorbis.so.0 libogg.so.0 libvorbisfile.so.3

-- 
     2. That which causes joy or happiness.

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lebrun.kern.log"

Nov  2 17:01:52 lebrun kernel: SysRq : Show Global CPU Regs
Nov  2 17:01:52 lebrun kernel:   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
Nov  2 17:01:52 lebrun kernel:              TPC[sparc64_realfault_common+0x8/0x20]
Nov  2 17:01:52 lebrun kernel: * CPU[  1]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[sh:12919]
Nov  2 17:02:04 lebrun kernel: SysRq : Show Global CPU Regs
Nov  2 17:02:04 lebrun kernel:   CPU[  0]: TSTATE[0000000080009604] TPC[0000000000407924] TNPC[0000000000407928] TASK[dpkg-query:10813]
Nov  2 17:02:04 lebrun kernel:              TPC[sparc64_realfault_common+0x8/0x20]
Nov  2 17:02:04 lebrun kernel: * CPU[  1]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[sh:12928]
Nov  2 17:17:02 lebrun kernel: SysRq : Show Global CPU Regs
Nov  2 17:17:02 lebrun kernel:   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000407924] TNPC[0000000000407928] TASK[dpkg-query:10813]
Nov  2 17:17:02 lebrun kernel:              TPC[sparc64_realfault_common+0x8/0x20]
Nov  2 17:17:02 lebrun kernel: * CPU[  1]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[sh:16444]

--y0ulUmNC+osPPQO6--
