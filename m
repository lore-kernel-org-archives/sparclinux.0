From: Meelis Roos <mroos@linux.ee>
Date: Thu, 30 May 2019 07:44:47 +0000
Subject: Re: [PATCH] vmalloc: Don't use flush flag when no exec perm
Message-Id: <67241836-621c-6933-1278-f04aedcefcb3@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20190529055104.6822-1-rick.p.edgecombe@intel.com>
 <89d6dee949e4418f0cca4cc6c4c9b526c1a5c497.camel@intel.com>
In-Reply-To: <89d6dee949e4418f0cca4cc6c4c9b526c1a5c497.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "jeyu@kernel.org" <jeyu@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "ard.biesheuvel@arm.com" <ard.biesheuvel@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "namit@vmware.com" <namit@vmware.com>, "luto@kernel.org" <luto@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>

>> The addition of VM_FLUSH_RESET_PERMS for BPF JIT allocations was
>> bisected to prevent boot on an UltraSparc III machine. It was found
>> that
>> sometime shortly after the TLB flush this flag does on vfree of the
>> BPF
>> program, the machine hung. Further investigation showed that before
>> any of
>> the changes for this flag were introduced, with
>> CONFIG_DEBUG_PAGEALLOC
>> configured (which does a similar TLB flush of the vmalloc range on
>> every vfree), this machine also hung shortly after the first vmalloc
>> unmap/free.
>>
>> So the evidence points to there being some existing issue with the
>> vmalloc TLB flushes, but it's still unknown exactly why these hangs
>> are
>> happening on sparc. It is also unknown when someone with this
>> hardware
>> could resolve this, and in the meantime using this flag on it turns a
>> lurking behavior into something that prevents boot.
> 
> The sparc TLB flush issue has been bisected and is being worked on now,
> so hopefully we won't need this patch:
> https://marc.info/?l=linux-sparc&m5915694304118&w=2

And the sparc64 patch that fixes CONFIG_DEBUG_PAGEALLOC also fixes booting
of the latest git kernel on Sun V445 where my problem initially happened.

-- 
Meelis Roos <mroos@linux.ee>
