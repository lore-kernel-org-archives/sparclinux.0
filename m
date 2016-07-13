From: joe moriarty <joe.moriarty@oracle.com>
Date: Wed, 13 Jul 2016 21:25:45 +0000
Subject: Mapping PADDR into virtual memory problem.
Message-Id: <4701cc90-2a15-0ab9-3527-170ce306a51d@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm stuck trying to get this to work and I don't know why what I am 
doing doesn't work.  I'm hoping maybe someone on here has a suggestion.  
The piece of code below is suppose to take a PADDR and memory map it to 
a kernel address.  The output I get from the code below is shown here:

PCI: Enabling device: (0002:08:00.0), cmd 3
vm_area->phys_addr=0x0008080100040000
vaddr=0x0000000136180000
nr_pages2
page protection =0x9C08080100040690
I/O address location mapped
ioread32 RegBase[0] = 0x00000000
vread RegBase[0] = 0x00000000
PCI: Enabling device: (0002:09:00.0), cmd 3
vm_area->phys_addr=0x0008080110040000
vaddr=0x0000000136200000
nr_pages2
page protection =0x9C08080110040690
I/O address location mapped
ioread32 RegBase[0] = 0x00000000
vread RegBase[0] = 0x00000000
PCI: Enabling device: (0002:0a:00.0), cmd 3
vm_area->phys_addr=0x0008080120040000
vaddr=0x0000000136280000
nr_pages2
page protection =0x9C08080120040690
I/O address location mapped
ioread32 RegBase[0] = 0x00000000
vread RegBase[0] = 0x00000000
PCI: Enabling device: (0002:0b:00.0), cmd 3
vm_area->phys_addr=0x0008080130040000
vaddr=0x0000000136300000
nr_pages2
page protection =0x9C08080130040690
I/O address location mapped
ioread32 RegBase[0] = 0x00000000
vread RegBase[0] = 0x00000000

I know I should be getting 0x00EA0408 from RegBase[0].
Do you see anything obvious that is wrong?

  void __iomem *ioremap_prefetch(unsigned long offset, unsigned long size)
{
         struct vm_struct *vm_area = NULL;
         unsigned long vaddr;
         int error = 0, tmp_val;
         pgprot_t prot = __pgprot(pgprot_val(PAGE_SHARED) | 
(_PAGE_PADDR_4V &
                         offset));
         void __iomem *ret_addr;

         /*
          * Get Contiguous Kernel Virtual Memory Area.  Note: 
get_vm_area will
          * page align the area to use.
          */
         vm_area = get_vm_area(size, VM_IOREMAP | VM_NO_GUARD);
         if (!vm_area) {
                 printk("Unable to allocate Contiguous Virtual Memory 
for Mapping
\n");
                 error = 1;
                 goto done;
         }
         vm_area->phys_addr = (phys_addr_t)offset;
         vm_area->nr_pages = size / PAGE_SIZE;
         vaddr = (unsigned long)vm_area->addr;
         printk("vm_area->phys_addr=0x%016llX\n", (unsigned long 
long)vm_area->ph
ys_addr);
         printk("vaddr=0x%016llX\n", (unsigned long long)vaddr);
         printk("nr_pages=%d\n", vm_area->nr_pages);
         printk("page protection =0x%08lX\n", (unsigned 
long)pgprot_val(prot));
         if(ioremap_page_range((unsigned long)vm_area->addr,
                               (unsigned long)vm_area->addr + size,
                               vm_area->phys_addr, prot)) {
                 printk("Unable to Map Page Range.\n");
                 error = 1;
                 goto done;
         }
         else {
                 printk("I/O address location mapped\n");
                 ret_addr = vm_area->addr;
                 printk("ioread32 RegBase[0] = 0x%08X\n", 
ioread32(ret_addr));
                 vread((char *)&tmp_val, ret_addr, 4);
                 printk("vread RegBase[0] = 0x%08X\n", tmp_val);
         }

done:
         if(error) {
                 /*
                  * Cleanup After oneself
                  */
                 free_vm_area(vm_area);
                 ret_addr = 0;
         }
         return (ret_addr);
         //return ((void __iomem *)offset);
}

Thanks In Advance,
Joe
