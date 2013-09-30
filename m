From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Mon, 30 Sep 2013 23:47:48 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <524A0DA4.4080709@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/30/2013 09:31 AM, David Miller wrote:
> This is a respin of the original page_offset and 64-bit page
> table changes with some minor changes and a bug fix:
>
> 1) Bob's ACKs for the first 6 patches added.
>
> 2) Don't use "UL" postfix for shift counts, there is code that
>     wants those to be "int", particularly printfs in mm/mm_init.c
>     that use the "%d" format specifier for SECTIONS_SHIFT.
>
> 3) Adjust VA_HOLE defines to match what the new 3-level page
>     tables can actually provide.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> --
Allocate 10 hugepages, and run a test using tool 'fio'  with following 
jobfile.
Fio just hangs. Basically issue is with O_DIRECT and hugepages. If you 
comment
out "direct=1" from jobfile test works fine.


[global]
bs=8k
randrepeat=1
mem=shmhuge
size0m
direct=1
[job2]
ioengine=psync
rw=randrw
filename=file1:file2

cat  /proc/49667/stack
[<00000000004209d4>] tl0_irq14+0x14/0x20
[<0000000000570ffc>] hugetlb_fault+0xbc/0x360
[<000000000057135c>] follow_hugetlb_page+0xbc/0x300
[<000000000055526c>] __get_user_pages+0x2ec/0x3a0
[<00000000005553e4>] get_user_pages+0x44/0x60
[<0000000000457590>] get_user_pages_fast+0xf0/0x220
[<00000000005ca878>] do_direct_IO+0xed8/0x1c80
[<00000000005cbb44>] __blockdev_direct_IO+0x344/0x1640
[<0000000010320444>] ext4_ind_direct_IO+0xe4/0x440 [ext4]
[<00000000102dc888>] ext4_ext_direct_IO+0x1c8/0x2c0 [ext4]
[<00000000102dca7c>] ext4_direct_IO+0xfc/0x200 [ext4]
[<000000000052d4ac>] generic_file_aio_read+0x1ec/0x220
[<000000000058dd98>] do_sync_read+0x58/0xa0
[<000000000058f42c>] vfs_read+0x6c/0x140
[<000000000058f568>] SyS_pread64+0x68/0x80
[<00000000004061d4>] linux_sparc_syscall+0x34/0x44


[root@localhost ~]# cat  /proc/49667/stack
[<0000000000538f58>] put_compound_page+0x38/0x1c0
[<000002eab77ca457>] 0x2eab77ca457


[root@localhost ~]# cat  /proc/49667/stack
[<0000000000538f2c>] put_compound_page+0xc/0x1c0
[<000000000053912c>] put_page+0x4c/0x60
[<0000000000571124>] hugetlb_fault+0x1e4/0x360
[<000000000057135c>] follow_hugetlb_page+0xbc/0x300
[<000000000055526c>] __get_user_pages+0x2ec/0x3a0
[<00000000005553e4>] get_user_pages+0x44/0x60
[<0000000000457590>] get_user_pages_fast+0xf0/0x220
[<00000000005ca878>] do_direct_IO+0xed8/0x1c80
[<00000000005cbb44>] __blockdev_direct_IO+0x344/0x1640
[<0000000010320444>] ext4_ind_direct_IO+0xe4/0x440 [ext4]
[<00000000102dc888>] ext4_ext_direct_IO+0x1c8/0x2c0 [ext4]
[<00000000102dca7c>] ext4_direct_IO+0xfc/0x200 [ext4]
[<000000000052d4ac>] generic_file_aio_read+0x1ec/0x220
[<000000000058dd98>] do_sync_read+0x58/0xa0
[<000000000058f42c>] vfs_read+0x6c/0x140
[<000000000058f568>] SyS_pread64+0x68/0x80
[<00000000004061d4>] linux_sparc_syscall+0x34/0x44

thanks,
-Guru


