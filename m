From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Wed, 26 Sep 2007 19:21:42 +0000
Subject: More than 4G of memory on Sparc32?
Message-Id: <f43fc5580709261221y47790f7en4726a74122d42191@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I've tried to add support to Qemu (and OpenBIOS) for more than 4G of
memory for the Sparc32 target. But now it seems that Linux can't use
this memory after all. The first show stopper is this code in
arch/sparc/prom/memory.c:

111                 /* Grrr, have to traverse the prom device tree ;( */
112                 node = prom_getchild(prom_root_node);
113                 node = prom_searchsiblings(node, "memory");
114                 num_regs = prom_getproperty(node, "available",
115                                             (char *) prom_reg_memlist,
116                                             sizeof(prom_reg_memlist));
117                 num_regs = (num_regs/sizeof(struct linux_prom_registers));
118                 for(iter=0; iter<num_regs; iter++) {
119                         prom_phys_avail[iter].start_adr 120                                 (char *) prom_reg_memlist[iter].phys_addr;
121                         prom_phys_avail[iter].num_bytes 122                                 (unsigned long)
prom_reg_memlist[iter].reg_size;
123                         prom_phys_avail[iter].theres_more 124                                 &prom_phys_avail[iter+1];
125                 }

Here prom_reg_memlist[iter].which_io is not used at all. It would be
needed to access the memory above the first 4G.

Some real Sparc32 machines could have >4G RAM (SC2000), maybe nobody
tried to run Linux on those. The BSDs aren't any better.

Will this ever be fixed? Anybody out there with a real machine and
lots of memory?
