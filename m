From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Wed, 26 Jan 2005 08:57:25 +0000
Subject: Re: FPU context switching fix for SMP
Message-Id: <41f75b75a4c13@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <41f753cabb795@wp.pl>
In-Reply-To: <41f753cabb795@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dnia 26-01-2005 o godz. 9:26 William Lee Irwin III napisa=B3(a):
> On Wed, Jan 26, 2005 at 09:24:42AM +0100, Krzysztof Helt wrote:
> > Here is a patch for FPU context switching in SMP.
> > A copy_thread() function clears PF_USEDFPU flag for a new thread,
> > but it does not clear the PSR_EF bit. Thus, a first FPU exception
> > called from the child thread is not handled properly. I made the
> > patch after PPC and MIPS architectures - both clear a similar bit
> > in copy_thread.
> > This bug does not exist in the UP kernel, probably because it
> > does not rely on PF_USEDFPU flag.
> > The patch below should be applied for both 2.4 and 2.6 branches.
> > I tested it with a test-fenv program from  glibc testsuite. The
> > test fails the same test cases in both SMP and UP with  the patch
> > applied. Without the patch, the test on SMP kernel failes in
> > almost two times more testcases.
>=20
> Are you sure a bugfix merits a copyright attribution? It's atypical
> elsewhere...
>=20
>=20

So please remove it. I am quite new, so just don't know how to
measure it...

Krzysztof


----------------------------------------------------
W Stepford kobiety s=B1 idealne, a m=EA=BFczy=BCni szcz=EA=B6liwi, dlaczego?
Zobacz, Nicole Kidman w filmie "=AFony ze Stepford"=20
Musisz je mie=E6 na DVD i Wideo!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Ffilm.wp.pl%2Fp%2Ffilm.html%3Fid%3D244=
49&sid05


