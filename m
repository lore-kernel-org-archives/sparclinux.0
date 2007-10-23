From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Tue, 23 Oct 2007 17:40:55 +0000
Subject: Re: LTP results on 2.6.23 sparc32
Message-Id: <20071023194055.9de62bd4.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20071022231034.GA17612@palantir8>
In-Reply-To: <20071022231034.GA17612@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 23 Oct 2007 00:10:34 +0100
Martin Habets <errandir_news@mph.eclipse.co.uk> wrote:

> Not investigated yet:
> 
> palantir13:~# kernel BUG at mm/highmem.c:196!
>               \|/ ____ \|/
>               "@'/ ,. \`@"
>               /_| \__/ |_\
>                  \__U_/
> pipe04(3665): Kernel bad trap [#1]
> PSR: 400010c0 PC: f006b010 NPC: f006b014 Y: 00000000    Not tainted
> PC: <kunmap_high+0xac/0xd8>
> %G: 000000c4 400010e7  f01f5084 f01f5078  0054d000 f14ba000  f0a82000 f076fdd8
> %O: 00000023 f01c9cc0  000000c4 efb4a9ec  00000000 00000000  f0a83c90 f006b008
> RPC: <kunmap_high+0xa4/0xd8>
> %L: 00000074 f06f90c0  f019aea4 00000002  00000080 00000000  f0a82000 efb49002
> %I: f06f90c0 00000003  fcfe1000 f0224000  00000090 f00f8b70  f0a83cf8 f0087da0
> Caller[f0087da0]: pipe_read+0x24c/0x47c
> Caller[f0081998]: do_sync_read+0xac/0xe4
> Caller[f0081a6c]: vfs_read+0x9c/0xcc
> Caller[f0081c84]: sys_read+0x38/0x64
> Caller[f001541c]: syscall_is_too_hard+0x3c/0x40
> Caller[00010ce8]: 0x10cf0
> Instruction DUMP: 921020ce  7ffead1e  01000000 <91d02005> 7fff1ac6  81e80000  82184005  80a00001  10bfffec 
> note: pipe04[3665] exited with preempt_count 1
> BUG: scheduling while atomic: pipe04/0x04000001/3665
> [f019a9cc : cond_resched+0x40/0x48 ] [f0038704 : put_files_struct+0xa4/0xec ] [f0038f98 : do_exit+0x184/0x8f0 ] [f00166f8 : die_if_kernel+0x13c/0x148 ] [f0016754 : do_hw_interrupt+0x50/0x8c ] [f00146a0 : bad_trap_handler+0x28/0x30 ] [f006b008 : kunmap_high+0xa4/0xd8 ] [f0087da0 : pipe_read+0x24c/0x47c ] [f0081998 : do_sync_read+0xac/0xe4 ] [f0081a6c : vfs_read+0x9c/0xcc ] [f0081c84 : sys_read+0x38/0x64 ] [f001541c : syscall_is_too_hard+0x3c/0x40 ] [00010ce8 : 0x10cf0 ] 
> BUG: soft lockup - CPU#2 stuck for 11s! [pan:3668]
> PSR: 400000c3 PC: f019c0f4 NPC: f019c0ec Y: 00000012    Tainted: G      D
> PC: <_spin_trylock_bh+0x40/0x70>
> %G: 00000000 00000002  000000ff f0965720  f0abe1d0 efffe000  f0af0000 00000040
> %O: f02241a0 f14559e0  efffffc3 00000000  00000001 00000007  f0af1d18 f006b04c
> RPC: <kmap_high+0x10/0x234>
> %L: f098ade0 f0081aa0  f0085f98 00000040  00000080 00000000  f0af0000 00000006
> %I: f071fea0 efffefc3  00000001 80808080  f0224000 00000008  f0af1db0 f0085b5c
> 

I traced this bug but as I am not skilled enough to handle this I can only share my findings.

The crash happens due to ops pointer becoming NULL in the following line (fs/pipe.c: 306):

 const struct pipe_buf_operations *ops = buf->ops

Then ops->something is called and it is crash obviously. It does not happen on UP kernel.

The same (buf->ops becoming NULL) happens in corresponding pipe_write() function.

Regards,
Krzysztof


----------------------------------------------------------------------
Masz jesienna depresje? Sprawdz jak sobie z nia radzic!
Kliknij >>> http://link.interia.pl/f1c45

