From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 22 Dec 2020 17:58:59 +0000
Subject: sparc32: Init process fails to load with generic kmap atomic
Message-Id: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, sparclinux <sparclinux@vger.kernel.org>, linux-mm@kvack.org
Cc: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>


Unfortunately I did not see this problem before I encountered it in
master. Commit 3293efa9780712ad8504689e0c296d2bd33827d5

    sparc/mm/highmem: Switch to generic kmap atomic

     No reason having the same code in every architecture

     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
     Cc: "David S. Miller" <davem@davemloft.net>
     Cc: Arnd Bergmann <arnd@arndb.de>
     Link: https://lore.kernel.org/r/20201103095858.197568209@linutronix.de

prevents the init process to be started for me on a sparc32 LEON. On the
commit before this it works. Details below from that commit but I get
the same behavior on current master.

 From as far as I have gotten into hunting down the problem, I get a
failure from load_elf_binary here:

	/* First of all, some simple consistency checks */
	if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
		goto out;

at least seemingly due to the kaddr from copy_page_to_iter in
lib/iov_iter.c

	if (i->type & (ITER_BVEC|ITER_KVEC)) {
		void *kaddr = kmap_atomic(page);
		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);

where kaddr points to memory with all zeroes (from an earlier bzero) in 
this context:

#0  _copy_to_iter (addr=0xfcffe000, bytes=0x100, i=0xf201fd78)
                at lib/iov_iter.c:635
#1  copy_to_iter (i=0xf201fd78, bytes=0x1ce, addr=0xfcffe000)
                at include/linux/uio.h:137
#2  copy_page_to_iter (page=0xf137ede0, offset=0x0, bytes=0x1ce, 
i=0xf201fd78)
                at lib/iov_iter.c:920
#3  shmem_file_read_iter (iocb=0xf201fd90, to=0xf201fd78)
                at mm/shmem.c:2661
#4  __kernel_read (file=0xf2103900, buf=0xf241365c, count=0x100, 
pos=0xf201fe80)
                at fs/read_write.c:454
#5  kernel_read (file=0xf2103900, buf=0xf241365c, count=0x100, 
pos=0xf201fe80)
                at fs/read_write.c:472
#6  prepare_binprm (bprm=0xf2413600)
                at fs/exec.c:1633
#7  search_binary_handler (bprm=0xf2413600)
                at fs/exec.c:1687
#8  exec_binprm (bprm=0xf2413600)
                at fs/exec.c:1744
#9  bprm_execve (bprm=0xf2413600, fd=<opt>, filename=<opt>, flags=<opt>)
                at fs/exec.c:1820
#10 kernel_execve (kernel_filename=<opt>,
                    argv=0xf050d4f0 <argv_init>,
                    envp=0xf050d468 <envp_init>)
                at fs/exec.c:1969
#11 kernel_init (unused=0x0)
                at init/main.c:1427

I will have to continue to dig deeper into this in January. If anyone
has any ideas how this could stem from this kmap patch, I am all ears.

-- 
Andreas Larsson
Software Engineer
Cobham Gaisler
