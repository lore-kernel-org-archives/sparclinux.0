From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 08 Aug 2008 14:28:26 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <a4423d670808080728s68d351a6l869152f5908eb6d8@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670808080314weed9178o9f9ef52803a68501@mail.gmail.com>
	 <20080808.033811.129671951.davem@davemloft.net>
	 <a4423d670808080356r6573102am8a1eb9dcc83910c8@mail.gmail.com>
	 <20080808.041814.41687650.davem@davemloft.net>
In-Reply-To: <20080808.041814.41687650.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2008/8/8 David Miller <davem@davemloft.net>:
> Please also double check that you patched the kernel with my
> fix correctly.  I used your exact config, on the exact same
> kind of system, reproducing the exact same hang, and it goes
> away with my fix.
>
It can be a different compiler version,
but I tried 4.3.1 and 4.1.2 with the same result.

After I removed CON_BOOT warnings apear after
Locking API testsuite:
<..>
Good, all 218 testcases passed!
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
== here =Memory: 1019600k available (2672k kernel code, 1264k data, 128k init)
[fffff80000000000,000000003ff46000]
SLUB: Genslabs, HWalign2, Order=0-2, MinObjects=8, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 884.33 BogoMIPS (lpjD21694)

Is it possible that lockdep messages did not appear when CON_BOOT was
in the flags?

Hope it will help.
