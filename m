From: David Miller <davem@davemloft.net>
Date: Sun, 27 Jul 2008 07:03:34 +0000
Subject: Re: sparc64 tracehook
Message-Id: <20080727.000334.234979595.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080726221221.DCF88154280@magilla.localdomain>
In-Reply-To: <20080726221221.DCF88154280@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Sat, 26 Jul 2008 15:12:21 -0700 (PDT)

> Hi!  I said I was leaving it to you now, but here is this anyway.  This
> differs from what I posted before only in a couple of decls in syscall.h
> that were incompatible with gcc-3.x.  It forks from the upstream-merged
> tracehook now, so you can git-pull it directly if you like.

Did you build test this at all?

cc1: warnings being treated as errors
arch/sparc64/kernel/ptrace.c: In function =E2=80=98syscall_trace=E2=80=99:
arch/sparc64/kernel/ptrace.c:1072: warning: ignoring return value of =E2=80=
=98tracehook_report_syscall_entry=E2=80=99, declared with attribute warn_un=
used_result
make[1]: *** [arch/sparc64/kernel/ptrace.o] Error 1
make: *** [arch/sparc64/kernel] Error 2
make: *** Waiting for unfinished jobs....
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
