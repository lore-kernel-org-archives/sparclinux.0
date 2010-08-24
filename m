From: Timur Tabi <timur@freescale.com>
Date: Tue, 24 Aug 2010 01:37:23 +0000
Subject: Re: [PATCH 1/2] powerpc: Make rwsem use "long" type
Message-Id: <AANLkTinsTMxmhScg2nfr=4hASqPbsqAOSgnG-V21N-P+@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<1282281295.22370.400.camel@pasglop>
In-Reply-To: <1282281295.22370.400.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On Fri, Aug 20, 2010 at 12:14 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> =A0static inline int rwsem_is_locked(struct rw_semaphore *sem)
> =A0{
> - =A0 =A0 =A0 return (sem->count !=3D 0);
> + =A0 =A0 =A0 return sem->count !=3D 0;
> =A0}

Does this change make the code do anything different?

--=20
Timur Tabi
Linux kernel developer at Freescale
