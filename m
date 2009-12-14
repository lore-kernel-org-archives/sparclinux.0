From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 14 Dec 2009 14:22:16 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.0912141511280.27692@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Monday 2009-12-14 04:25, David Miller wrote:
>
>cp_new_stat() handles "struct stat", not "struct stat64"
>
>cp_new_stat64() does that, and it unconditionally fills in
>the nsec parts.


I added some dump_stack() to all the cp_* functions, leading
to this result:

Call Trace:
 [0000000000522990] cp_new_stat+0xdc/0x134
 [0000000000522d9c] SyS_newfstat+0x24/0x38
 [0000000000406294] linux_sparc_syscall+0x34/0x44

Is glibc doing the right thing here? Calling sys_newfstat (instead of 
sys_newfstat64) for fstat64()?


[gcc-bug: see http://marc.info/?l=linux-sparc&m6074570109411&w=2 ]
