From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 04 Jul 2006 13:57:02 +0000
Subject: 2.6.7:Oops in page_referenced_one
Message-Id: <20060704135702.GA23076@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On my SS20 I get the following oops when doing a 'make C=2' using 2.6.17:

  CHECK   arch/sparc/kernel/sun4d_irq.c
arch/sparc/kernel/sun4d_irq.c:485:18: warning: cast removes address space of expression
  CC      arch/sparc/kernel/sun4d_irq.o
Unable to handle kernel paging request at virtual address fffff000
tsk->{mm,active_mm}->context = 00000432
tsk->{mm,active_mm}->pgd = fc08f400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
kswapd0(10): Oops [#1]
PSR: 401010c1 PC: f0060dcc NPC: f0060dd0 Y: 00000000    Not tainted
PC: <page_referenced_one+0x4/0x108>
%G: 00029121 00000001  00000000 f25a0f88  f0056c10 c0000040  f086a000 c0000040
%O: 00000000 003a6000  003a6000 00000432  00000000 00000000  f086bc08 f00d8350
RPC: <__atomic_add_return+0x1c/0x2c>
%L: 003a6000 f2a79000  f0166d28 00000010  00000020 00000000  f2804000 00000000
%I: f07acb60 ffffffc8  f086bcdc 00000006  61736d2f 6c696e75  f086bc78 f0060f14
Caller[f0060f14]: page_referenced_anon+0x44/0x78
Caller[f00610cc]: page_referenced+0xb0/0xc4
Caller[f00573c8]: shrink_active_list+0x460/0x498
Caller[f00574a0]: shrink_zone+0xa0/0x114
Caller[f0057a8c]: balance_pgdat+0x2d8/0x3b4
Caller[f0057c48]: kswapd+0xe0/0x100
Caller[f0014b74]: kernel_thread+0x34/0x50
Caller[f01cc278]: init_bootmem_node+0x4/0x10
Caller[00000000]: start+0xfffc000/0x10
Instruction DUMP: 81c7e008  81e80000  9de3bf90 <c2066004> c4062014  c6066048  90100018  84208003  e2064000 
Unable to handle kernel paging request at virtual address fffff000
tsk->{mm,active_mm}->context = 00000432
tsk->{mm,active_mm}->pgd = fc08f400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
cc1(598): Oops [#2]
PSR: 401010c4 PC: f0060dcc NPC: f0060dd0 Y: 00000000    Not tainted
PC: <page_referenced_one+0x4/0x108>
%G: f2e5cfc0 00000001  00000000 f25a0f88  f0166b34 c0000040  f2804000 c0000040
%O: 00000000 00000064  f0b4db08 f0b4df38  f2f02998 f2f02998  f28058f8 f00d8350
RPC: <__atomic_add_return+0x1c/0x2c>
%L: 404010c5 f01663fc  f0166b3c 00000080  00000001 00000001  f0868000 f0194800
%I: f07ad0a0 ffffffc8  f28059cc 00000000  0000000e 00000000  f2805968 f0060f14
Caller[f0060f14]: page_referenced_anon+0x44/0x78
Caller[f00610cc]: page_referenced+0xb0/0xc4
Caller[f00573c8]: shrink_active_list+0x460/0x498
Caller[f00574a0]: shrink_zone+0xa0/0x114
Caller[f00575a0]: shrink_zones+0x8c/0xa4
Caller[f005768c]: try_to_free_pages+0xd4/0x1fc
Caller[f0051e08]: __alloc_pages+0x110/0x2d8
Caller[f005c15c]: do_anonymous_page+0x34/0x1b4
Caller[f005c6c4]: __handle_mm_fault+0xfc/0x26c
Caller[f001ae88]: do_sparc_fault+0x10c/0x3e0
Caller[f0010f28]: srmmu_fault+0x58/0x68
Caller[000fd920]: 0xfd920
Instruction DUMP: 81c7e008  81e80000  9de3bf90 <c2066004> c4062014  c6066048  90100018  84208003  e2064000 


$ objdump -d /boot/vmlinuz-2.6.17-mph3

f0060dc8 <page_referenced_one>:
f0060dc8:	9d e3 bf 90 	save  %sp, -112, %sp
f0060dcc:	c2 06 60 04 	ld  [ %i1 + 4 ], %g1
f0060dd0:	c4 06 20 14 	ld  [ %i0 + 0x14 ], %g2
f0060dd4:	c6 06 60 48 	ld  [ %i1 + 0x48 ], %g3
f0060dd8:	90 10 00 18 	mov  %i0, %o0


From mm/rmap.c:

static int page_referenced_one(struct page *page,
	struct vm_area_struct *vma, unsigned int *mapcount)
{
	struct mm_struct *mm = vma->vm_mm;		// <= Oopses here


I see a similar oops on 2.6.16-rc2. Unforunately I got rid of my older kernels,
so I cannot say when this first occurred.
Anyone familiar with this? I could do with some tips how to debug this
further. For me this points to an MMU issue. Right?

Thanks,
-- 
Martin
