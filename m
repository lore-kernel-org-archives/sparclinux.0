From: David Miller <davem@davemloft.net>
Date: Mon, 25 Oct 2010 18:55:27 +0000
Subject: Re: [PATCH 2/3] sparc32: remove CONFIG_HAVE_PERF_EVENTS option
Message-Id: <20101025.115527.226780270.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-2-git-send-email-namhyung@gmail.com>
	<20101025.085937.226775583.davem@davemloft.net>
	<1288024279.1689.23.camel@leonhard>
In-Reply-To: <1288024279.1689.23.camel@leonhard>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: namhyung@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 26 Oct 2010 01:31:19 +0900

> 2010-10-25 (=BF=F9), 08:59 -0700, David Miller:
>> From: Namhyung Kim <namhyung@gmail.com>
>> Date: Tue, 26 Oct 2010 00:52:37 +0900
>>=20
>> > Remove HAVE_PERF_EVENTS and PERF_USE_VMALLOC under config
>> > SPARC because they're under SPARC64 too. Supporting
>> > perf_event needs atomic64 operations but AFAIK sparc32
>> > doesn't provide them, CMIIW. ;-) Also removes redundant
>> > HAVE_IRQ_WORK line.
>> >=20
>> > Signed-off-by: Namhyung Kim <namhyung@gmail.com>
>>=20
>> The generic non-hw perf event stuff builds fine on sparc32,
>> please don't remove this unless you have a legitimate build
>> failure to report and fix.
>>=20
>> Even if sparc32 doesn't provide atomic64_t support, it very
>> easily could do so using include/asm-generic/atomic64.h which
>> implements them using spinlocks.
>=20
> Now I see following build failure without this patch. Maybe some work is
> needed to deal with atomic64_t. I'll try to prepare for it soon. Thanks.

Nevermind, I see the issue.  Ok, your patch is fine:

Acked-by: David S. Miller <davem@davemloft.net>
