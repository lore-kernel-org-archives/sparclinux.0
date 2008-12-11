From: David Miller <davem@davemloft.net>
Date: Thu, 11 Dec 2008 08:50:08 +0000
Subject: Re: what's a fast syscall
Message-Id: <20081211.005008.33553543.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob <bo-liu@hotmail.com>
Date: Thu, 11 Dec 2008 15:16:17 +0800

> I have read the code about syscall in file entry.S and didn't
> known what's a fast syscall.
>  
> And why line 1322 can distinguish it through "andcc" (there %l7 is
> the sys_* funtions' address?) ?

We used to have fast syscall handlers that ran directly in assembler
without doing a trap entry and exit which is normally necessary to
call the normal C code implementations.

The way this was distinguished was by setting the low bit in the
syscall table entry.  Since all Sparc instructios must be 4 byte
aligned, this works. We just need to clear that bit before jumping to
the address.

Fast syscalls were removed a long time ago, but the support code still
lives :)
