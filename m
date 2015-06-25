From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 25 Jun 2015 15:24:24 +0000
Subject: [next] nfs update breaks build on sparc
Message-Id: <20150625152424.GC3069@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150625145528.GA3069@windriver.com>
In-Reply-To: <20150625145528.GA3069@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trond Myklebust <trond.myklebust@primarydata.com>
Cc: linux-next@vger.kernel.org, sparclinux@vger.kernel.org


New breakage seen in linux-next today:

ERROR: "__xchg_called_with_bad_pointer" [fs/nfs/flexfilelayout/nfs_layout_flexfiles.ko] undefined!
ERROR: "__cmpxchg_called_with_bad_pointer" [fs/nfs/flexfilelayout/nfs_layout_flexfiles.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2

I tried to reproduce it locally so I could run a bisect,
but it must be toolchain specific because I don't see it.

Paul.

