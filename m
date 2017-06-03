From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Sat, 03 Jun 2017 02:18:07 +0000
Subject: Re: [PATCH 1/7] lib: Add shared copies of some GCC library routines
Message-Id: <mhng-30ac217d-aaf3-47bd-bfe7-cc86e4660f58@palmer-si-x1c4>
List-Id: <sparclinux.vger.kernel.org>
References: <4448bb28-fa2f-3a4c-753e-46bc4c3815a3@imgtec.com>
In-Reply-To: <4448bb28-fa2f-3a4c-753e-46bc4c3815a3@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matt.redfearn@imgtec.com
Cc: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 24 May 2017 01:52:13 PDT (-0700), matt.redfearn@imgtec.com wrote:
> Hi Palmer
>
>
> On 23/05/17 23:05, Palmer Dabbelt wrote:
>> Many ports (m32r, microblaze, mips, parisc, score, and sparc) use
>> functionally identical copies of various GCC library routine files,
>> which came up as we were submitting the RISC-V port (which also uses
>> some of these).
>>
>> This patch adds a new copy of these library routine files, which are
>> functionally identical to the various other copies.  These are
>> availiable via Kconfig as CONFIG_LIB_$ROUTINE, which currently isn't
>> used anywhere.
>
> Note that, on MIPS, we had to mark the compiler intrinsics as notrace
> (see commit aedcfbe06558a9f53002e82d5be64c6c94687726) because if the
> compiler requires the intrinsic in the ftrace path, it then tries to
> trace itself leading to infinite recursion and stack overflow. So I'd
> suggest you mark the generic versions notrace as well.

Sorry, I didn't notice that.  I got a bit swamped responding to the RISC-V
port's code reviews, but assuming nobody has merged any of this I'll submit a
v2 patch set that fixes this (and some other errors I believe I introduced)
once I get through all my email.

Thanks!
