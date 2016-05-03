From: David Miller <davem@davemloft.net>
Date: Tue, 03 May 2016 16:33:01 +0000
Subject: Re: [crypto / sparc64] cryptomgr_test OOPS
Message-Id: <20160503.123301.298039059390449291.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqyMwme53etMrnx3xkpGsR6-W88RHLA3nh0GCGAzcz5=Fw@mail.gmail.com>
In-Reply-To: <CADxRZqyMwme53etMrnx3xkpGsR6-W88RHLA3nh0GCGAzcz5=Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 3 May 2016 16:54:18 +0300

> I have git kernel OOPS (4.6.0-rc6) on sparc64. This OOPS does not
> happen, if I set the following kernel option:
> 
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> 
> Can someone please look at https://bugzilla.kernel.org/show_bug.cgi?id7551 ?

The lib/mpi/ code hasn't been touched in a long time, so I can only see that it might
be the crypto/rsa.c changes that happened this release.

Can you possibly bisect this or at least tell us that 4.5 doesn't have this problem?
