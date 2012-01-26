From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jan 2012 22:32:02 +0000
Subject: [PATCH 0/2] Fix the sparc32 mpilib build mess.
Message-Id: <20120126.173202.2207050843577467461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, dmitry.kasatkin@intel.com, linux-kernel@vger.kernel.org


The long and short of it is that the longlong.h header added by
the mpilib code is quite old and out of date.

Here I've solved the clz_tab[] multiple definition problem as
well as the outdated udiv_qrnnd() definition, but long term
we should probably have a more uptodate longlong.h header
provides at include/linux/longlong.h to avoid this kind of
stuff in the future.

It's a part of the libgcc interface and therefore has no
business being tucked down deep under lib/foo/ somewhere.
