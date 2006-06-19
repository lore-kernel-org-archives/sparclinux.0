From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Mon, 19 Jun 2006 20:38:25 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <20060619203823.GB2324@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

5 days, 2 hours, 52 minutes, 18 seconds ago,=20
Ludovic Court=E8s wrote:
> Using GCC 3.4.6 (from Debian sid) fixes the problem.

Actually it doesn't.  For some reason, I now hit the following ICE with
3.4.6 (Debian's `gcc-3.4', version 3.4.6-2) systematically:

    CC      fs/proc/proc_misc.o
    CC      fs/dnotify.o
  distcc[13671] ERROR: compile /home/ludo/.ccache/proc_misc.tmp.cheetah.136=
56.i on localhost failed
  fs/proc/proc_misc.c: In function `uptime_read_proc':
  fs/proc/proc_misc.c:109: internal compiler error: in choose_multiplier, a=
t expmed.c:2738
  Please submit a full bug report,
  with preprocessed source if appropriate.
  See <URL:http://gcc.gnu.org/bugs.html> for instructions.
  For Debian GNU/Linux specific bug reporting instructions,
  see <URL:file:///usr/share/doc/gcc-3.4/README.Bugs>.

I finally used 3.3.6 to built the whole kernel and I don't hit any ICE
there.  Is anybody building SPARC kernels with 3.4 or 4.x?

> However, the resulting kernel hangs right after the "Booting Linux..."
> message.

The kernel (once cleanly recompiled with 3.3.6) still hangs at the same
point, whether there are one or two CPUs in the machine.

I guess I should try to selectively revert some of the SMP patches in
order to try to find out what's causing this.  Any advice about how to
proceed?

Thanks,
Ludovic.

