From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 09:35:08 +0000
Subject: Re: 16550 serial support
Message-Id: <20080912093508.GA12785@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 11, 2008 at 06:40:00PM -0700, David Miller wrote:
> > OK, I did a clean rebuild and reboot, but no dice:
> > 
> > Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> > Unable to handle kernel NULL pointer dereference
> 
> Please add this follow-on patch:
> 
>  #ifdef CONFIG_SPARC
> -	ret = sunserial_register_minors(&serial8250_reg, nr_uarts);
> +	ret = sunserial_register_minors(&serial8250_reg, UART_NR);

OK, this is strange, now the loading attempt hangs. stracing it shows
looping...

open("/lib/modules/2.6.27-rc4/kernel/drivers/serial/8250.ko", O_RDWR) = 3
fcntl64(3, F_SETLKW, {type=F_WRLCK, whence=SEEK_SET, start=0, len=1}) = 0
open("/proc/modules", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f4c000
read(4, "ip6t_REJECT 6592 2 - Live 0x0000"..., 1024) = 1024
read(4, "80 0 - Live 0x0000000010062000\n8"..., 1024) = 207
nanosleep({0, 100000000}, NULL)         = 0
close(4)                                = 0
munmap(0xf7f4c000, 8192)                = 0
open("/proc/modules", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f4c000
read(4, "ip6t_REJECT 6592 2 - Live 0x0000"..., 1024) = 1024
read(4, "80 0 - Live 0x0000000010062000\n8"..., 1024) = 207
nanosleep({0, 100000000}, NULL)         = 0
close(4)                                = 0
munmap(0xf7f4c000, 8192)                = 0
open("/proc/modules", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f4c000
read(4, "ip6t_REJECT 6592 2 - Live 0x0000"..., 1024) = 1024
read(4, "80 0 - Live 0x0000000010062000\n8"..., 1024) = 207
nanosleep({0, 100000000}, NULL)         = 0
close(4)                                = 0
munmap(0xf7f4c000, 8192)                = 0
open("/proc/modules", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f4c000
read(4, "ip6t_REJECT 6592 2 - Live 0x0000"..., 1024) = 1024
read(4, "80 0 - Live 0x0000000010062000\n8"..., 1024) = 207
nanosleep({0, 100000000}, NULL)         = 0
close(4)                                = 0
munmap(0xf7f4c000, 8192)                = 0
open("/proc/modules", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f4c000
read(4, "ip6t_REJECT 6592 2 - Live 0x0000"..., 1024) = 1024
read(4, "80 0 - Live 0x0000000010062000\n8"..., 1024) = 207
nanosleep({0, 100000000}, NULL)         = 0
close(4)                                = 0
munmap(0xf7f4c000, 8192)                = 0
open("/proc/modules", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f4c000
read(4, "ip6t_REJECT 6592 2 - Live 0x0000"..., 1024) = 1024
read(4, "80 0 - Live 0x0000000010062000\n8"..., 1024) = 207
nanosleep({0, 100000000}, NULL)         = 0
close(4)                                = 0
munmap(0xf7f4c000, 8192)                = 0
open("/proc/modules", O_RDONLY)         = 4
[...]

For the record:

% cat /proc/modules
ip6t_REJECT 6592 2 - Live 0x000000001013e000
nf_conntrack_ipv6 16800 1 - Live 0x0000000010136000
ip6table_filter 5376 1 - Live 0x0000000010132000
ip6_tables 21264 1 ip6table_filter, Live 0x000000001012a000
ipv6 274464 26 ip6t_REJECT,nf_conntrack_ipv6, Live 0x00000000100e4000
ipt_REJECT 5696 2 - Live 0x00000000100e0000
xt_tcpudp 5824 20 - Live 0x00000000100dc000
nf_conntrack_ipv4 17816 1 - Live 0x00000000100d4000
xt_state 4672 2 - Live 0x0000000010050000
nf_conntrack 70160 3 nf_conntrack_ipv6,nf_conntrack_ipv4,xt_state, Live 0x00000000100c0000
iptable_filter 5568 1 - Live 0x000000001002a000
ip_tables 19920 1 iptable_filter, Live 0x00000000100b8000
x_tables 24520 6 ip6t_REJECT,ip6_tables,ipt_REJECT,xt_tcpudp,xt_state,ip_tables, Live 0x00000000100b0000
dm_snapshot 20416 0 - Live 0x00000000100a8000
dm_mirror 19584 0 - Live 0x00000000100a0000
dm_log 13441 1 dm_mirror, Live 0x000000001009a000
dm_mod 57232 3 dm_snapshot,dm_mirror,dm_log, Live 0x000000001008a000
qla1280 121232 0 - Live 0x000000001006a000
ohci_hcd 24480 0 - Live 0x0000000010062000
8250 29680 1 - Loading 0x0000000010054000
usbcore 127232 1 ohci_hcd, Live 0x000000001002e000
tg3 130052 0 - Live 0x0000000010008000
libphy 23936 1 tg3, Live 0x0000000010000000

-- 
     2. That which causes joy or happiness.
