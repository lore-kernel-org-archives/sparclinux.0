From: Joe Perches <joe@perches.com>
Date: Tue, 06 Sep 2016 15:29:33 +0000
Subject: Re: sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <1473175773.8300.6.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160903.230607.1667562673788737377.davem@davemloft.net>
         <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net>
         <20160903.235916.1892276070318494855.davem@davemloft.net>
         <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
         <57CBEFEA.3080007@iogearbox.net> <20160905130737.74f63abe@endymion>
         <20160905113704.GA10153@twins.programming.kicks-ass.net>
         <20160905135445.501814a1@endymion>
         <20160905115838.GC10153@twins.programming.kicks-ass.net>
         <20160906163413.470f37d4@endymion> <20160906144756.GF2794@worktop>
In-Reply-To: <20160906144756.GF2794@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Zijlstra <peterz@infradead.org>, Jean Delvare <jdelvare@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org

On Tue, 2016-09-06 at 16:47 +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2016 at 04:34:13PM +0200, Jean Delvare wrote:
> > > [diff "default"]
> > > =A0 =A0 =A0 =A0 xfuncname =3D "^[[:alpha:]$_].*[^:]$"
> > OK, I see. As mentioned somewhere else, it fails for labels which have
> > comments.=A0
> Heh, There's labels that have comments?

Only a few dozen.

The pattern with the perl-like $_ took me a depressingly
long time to parse followed by a self forehead slap.


