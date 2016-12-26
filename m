From: David Miller <davem@davemloft.net>
Date: Mon, 26 Dec 2016 20:59:11 +0000
Subject: Re: [sparc64] cryptomgr_test OOPS kernel 4.9.0+
Message-Id: <20161226.155911.1929580721580916933.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwxU+XjTe+jwfrDdsp7Vs47YsJHww3=bsENhrUsYgHvkg@mail.gmail.com>
In-Reply-To: <CADxRZqwxU+XjTe+jwfrDdsp7Vs47YsJHww3=bsENhrUsYgHvkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 25 Dec 2016 20:56:08 +0300

> Disabling kernel config option
> CRYPTO_MANAGER_DISABLE_TESTS
> i.e. enable run-time self tests, makes kernel unbootable:
> 
> tested with git kernels v4.9-8648-g5cc60aeedf31 and v4.9-12259-g7c0f6ba682b9

I'm getting this with the current GIT tree too, will try to see
what's going wrong.
