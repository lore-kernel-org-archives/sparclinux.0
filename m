From: Bob Picco <bpicco@meloft.net>
Date: Wed, 01 Oct 2014 14:29:00 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141001142900.GD22365@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Bob Picco wrote:	[Wed Oct 01 2014, 07:51:08AM EDT]
> Hi,
> David Miller wrote:	[Tue Sep 30 2014, 10:29:00PM EDT]
> > I assume this booted all the way to a login prompt or similar?
> Yes. I just cloned sparc.git during VPN and proxy quiet period.
> I'll attempt to hang on to T5-8 until we conclude :)
We seem to encounter the spec-jbb like issue under heavy threaded make
of sparc.git with our work. A similar load had no issue on local T5-2 and
T4-2. It raised its ugly head quickly on T5-8. It could be painful to pursue
on T5-8.

Last night I was pondering whether it might be slab related for spec-jbb.
Though I've not flushed these thoughts thoroughly in or out.

I'm in pursuit! Bloody dentist today.

[root@ca-qasparc24 ~]# Unable to handle kernel NULL pointer dereference
BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:183f3f4b6000
page:000600007fbb0c00 count:107055216 mapcount:-524287 mapping:          (null) index:0xfff8000107659c00
page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
page dumped because: bad pte
addr:0000000000124000 vm_flags:00000875 anon_vma:          (null) mapping:fff8003f18a06a78 index:12
vma->vm_ops->fault: filemap_fault+0x8/0x440
vma->vm_file->f_op->mmap: ext4_file_mmap+0x8/0x40 [ext4]
CPU: 497 PID: 19886 Comm: cc1 Tainted: G             L 3.17.0-rc7 #1
Call Trace:
 [0000000000567394] print_bad_pte+0x134/0x1e0
 [000000000056ade0] zap_pte_range+0x4c0/0x580
 [000000000056afd4] unmap_page_range+0x134/0x220
 [000000000056b11c] unmap_single_vma+0x5c/0xc0
 [000000000056b1a8] unmap_vmas+0x28/0x60
 [000000000056e248] exit_mmap+0x88/0x160
 [0000000000465c74] mmput+0x54/0xe0
 [00000000004691bc] exit_mm+0x13c/0x1c0
 [000000000046a750] do_exit+0x130/0x440
 [000000000046aa90] do_group_exit+0x30/0xc0
 [000000000046ab3c] SyS_exit_group+0x1c/0x40
 [0000000000406234] linux_sparc_syscall+0x34/0x44
