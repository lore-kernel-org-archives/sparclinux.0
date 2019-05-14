From: Meelis Roos <mroos@linux.ee>
Date: Tue, 14 May 2019 04:58:29 +0000
Subject: Re: bpf VM_FLUSH_RESET_PERMS breaks sparc64 boot
Message-Id: <a30b1eac-4a98-de52-e381-91a7a59f8042@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <4401874b-31b9-42a0-31bd-32bef5b36f2a@linux.ee>
 <b8493de00d9973f6f054814ed69d146b29207d3e.camel@intel.com>
 <102313756736cf8b34b36b1025102e2b75d16426.camel@intel.com>
In-Reply-To: <102313756736cf8b34b36b1025102e2b75d16426.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "peterz@infradead.org" <peterz@infradead.org>, "namit@vmware.com" <namit@vmware.com>

> I'm having trouble getting Debian Buster up and running on qemu-system-
> sparc64 and so haven't been able to reproduce. Is this currently working for
> people?

I just reinstalled the machine from
https://cdimage.debian.org/cdimage/ports/2019-05-09/debian-10.0-sparc64-NETINST-1.iso
and there's a even newer build upe one directory level.

> This patch involves re-setting memory permissions when freeing executable
> memory. It looks like Sparc64 Linux doesn't have support for the set_memory_()
> functions so that part shouldn't be changing anything. The main other thing that
> is changed here is always doing a TLB flush in vfree when the BPF JITs are
> freed. It will already sometimes happen so that shouldn't be too different
> either.

That part I do not know.

> So it doesn't seem extra especially likely to cause a sparc specific problem
> that I can see. Is there any chance this is an intermittent issue?

So far it seemed 100% reproducible, at least in the bisect that led here.
The only variation I saw was if it just sat there for newer git snapshot or spew
out RCU and workqueue lockup warnings soon like I posed.

I can do some tests and boot the same kernel some more times.

-- 
Meelis Roos
