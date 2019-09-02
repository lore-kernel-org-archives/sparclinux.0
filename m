From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Mon, 02 Sep 2019 06:08:31 +0000
Subject: Re: [PATCH v2 7/9] sparc64: numa: check the node id consistently for sparc64
Message-Id: <1e128e33-427f-19a2-0e13-95a9c0656ab1@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1567231103-13237-8-git-send-email-linyunsheng@huawei.com>
 <20190830.235337.570776316111294728.davem@davemloft.net>
 <0195eb73-99ae-fec2-3e11-2cb9e6677926@huawei.com>
 <20190831.130250.1236116087422472663.davem@davemloft.net>
In-Reply-To: <20190831.130250.1236116087422472663.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linuxarm@huawei.com, jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, mwb@linux.vnet.ibm.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com, will@kernel.org, cai@lca.pw, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, rppt@linux.ibm.com, borntraeger@de.ibm.com, dledford@redhat.com, mingo@redhat.com, jeffrey.t.kirsher@intel.com, benh@kernel.crashing.org, jhogan@kernel.org, nfont@linux.vnet.ibm.com, mattst88@gmail.com, len.brown@intel.com, gor@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org, rth@twiddle.net, axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de, paul.burton@mips.com, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, akpm@linux-foundation.org, robin.murphy@arm.com

On 2019/9/1 4:02, David Miller wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Sat, 31 Aug 2019 16:57:04 +0800
> 
>> Did you mean sparc64 system does not has ACPI, the device's node id will
>> not specified by ACPI, so the ACPI is unrelated here?
> 
> Yes, sparc64 never has and never will have ACPI.
> 
> This is also true for several other platforms where you have made this
> change.
> 
> The assumption of your entire patch set is that the semantics of the
> NUMA node ID are somehow completely defined by ACPI semantics.  Which
> is not true.

Thanks for pointing out.

The NUMA node id in sparc64 system is defined by DT semantics?

> 
> .
> 
