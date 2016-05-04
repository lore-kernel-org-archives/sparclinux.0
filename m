From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 04 May 2016 14:49:04 +0000
Subject: Re: [crypto / sparc64] cryptomgr_test OOPS
Message-Id: <CADxRZqws2yAMSqeMDYb6w6OUXJMMbv9wMaY7Zc6YX+szk2vO3g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160503.123301.298039059390449291.davem@davemloft.net>
	<20160504040731.GA25758@gondor.apana.org.au>
In-Reply-To: <20160504040731.GA25758@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>

On Wed, May 4, 2016 at 7:07 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> David Miller <davem@davemloft.net> wrote:
>> From: Anatoly Pugachev <matorola@gmail.com>
>> Date: Tue, 3 May 2016 16:54:18 +0300
>>
>>> I have git kernel OOPS (4.6.0-rc6) on sparc64. This OOPS does not
>>> happen, if I set the following kernel option:
>>>
>>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>>>
>>> Can someone please look at https://bugzilla.kernel.org/show_bug.cgi?id7551 ?
>>
>> The lib/mpi/ code hasn't been touched in a long time, so I can only see that it might
>> be the crypto/rsa.c changes that happened this release.
>>
>> Can you possibly bisect this or at least tell us that 4.5 doesn't have this problem?
>
> It would also be helpful to test the latest cryptodev tree which
> has a large number of MPI fixes from Nicolai Stange.

Herbert,

just tested cryptodev (
http://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
) kernel, same OOPS, but kernel version is 4.6.0-rc2+ .
kernel OOPS message - https://paste.fedoraproject.org/362554/23732641/
