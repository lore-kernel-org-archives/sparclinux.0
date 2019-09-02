From: David Miller <davem@davemloft.net>
Date: Mon, 02 Sep 2019 15:17:27 +0000
Subject: Re: [PATCH v2 7/9] sparc64: numa: check the node id consistently for sparc64
Message-Id: <20190902.081727.1498167275046613083.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <0195eb73-99ae-fec2-3e11-2cb9e6677926@huawei.com>
 <20190831.130250.1236116087422472663.davem@davemloft.net>
 <1e128e33-427f-19a2-0e13-95a9c0656ab1@huawei.com>
In-Reply-To: <1e128e33-427f-19a2-0e13-95a9c0656ab1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linyunsheng@huawei.com
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linuxarm@huawei.com, jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, mwb@linux.vnet.ibm.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com, will@kernel.org, cai@lca.pw, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, rppt@linux.ibm.com, borntraeger@de.ibm.com, dledford@redhat.com, mingo@redhat.com, jeffrey.t.kirsher@intel.com, benh@kernel.crashing.org, jhogan@kernel.org, nfont@linux.vnet.ibm.com, mattst88@gmail.com, len.brown@intel.com, gor@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org, rth@twiddle.net, axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de, paul.burton@mips.com, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, akpm@linux-foundation.org, robin.murphy@arm.com

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Mon, 2 Sep 2019 14:08:31 +0800

> The NUMA node id in sparc64 system is defined by DT semantics?

Sometimes, and in other cases other methods are used to determine
the NUMA node id.
