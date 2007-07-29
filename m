From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 02:17:39 +0000
Subject: [PATCH] v2.6.23-rc1 Sparc32 Serial Port Selection error
Message-Id: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-1952666620-1185675459=:28781"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-1952666620-1185675459=:28781
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi David,

The serial console code selection code needs to select the ports the 
otherway around. The attached patch fixes the problem.

--- linux-test/arch/sparc/kernel/prom.c~	2007-07-28 21:02:31.000000000 +0100
+++ linux-test/arch/sparc/kernel/prom.c	2007-07-29 02:38:54.000000000 +0100
@@ -460,7 +460,7 @@
  		strcpy(of_console_path, dp->full_name);
  		if (!strcmp(type, "serial")) {
  			strcat(of_console_path,
-			       (skip ? ":b" : ":a"));
+			       (skip ? ":a" : ":b"));
  		}
  		break;


Appling this patch has allowd me to log the NULL pointer failure in 
sun4c_update_mmu_cache:

Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.1.1.2
IP-Config: Complete:
       device=eth0, addr=10.1.1.2, mask=255.255.255.0, gw=10.1.1.32,
      host=10.1.1.2, domain=marknet, nis-domain=(none),
      bootserver=0.0.0.0, rootserver=10.1.1.4, rootpath=
Looking up port of RPC 100003/2 on 10.1.1.4
Looking up port of RPC 100005/1 on 10.1.1.4
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 132k freed
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = f0005000
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(1): Oops [#1]
PSR: 00101fc5 PC: f002244c NPC: f0022450 Y: 1e000000    Not tainted
PC: <sun4c_update_mmu_cache+0x80/0x1bc>
%G: 00000040 f02cf95c  f02cf940 00000000  f02cf940 00000000  ff000000 00000030
%O: f02cec54 f0290660  00000040 f03012a0  00000048 f01277b8  ff0019e0 f00223fc
RPC: <sun4c_update_mmu_cache+0x30/0x1bc>
%L: 008010e6 f03012a0  f0060d34 f03012a0  00000010 000a00d2  ff000000 00000001
%I: f02c8d48 effc0000  c8f00389 00001000  00000048 f01277b8  ff001a48 f006145c
Caller[f006145c]: handle_mm_fault+0x66c/0x69c
Caller[f0061580]: get_user_pages+0xf4/0x1e8
Caller[f007903c]: get_arg_page+0x34/0x8c
Caller[f0079168]: copy_strings+0xd4/0x36c
Caller[f0079420]: copy_strings_kernel+0x20/0x30
Caller[f007a648]: do_execve+0xdc/0x1d0
Caller[f00146c4]: sparc_execve+0x40/0x78
Caller[f0011428]: syscall_is_too_hard+0x3c/0x40
Caller[f0081374]: dupfd+0xf0/0x114
Caller[f00100b4]: init_post+0x98/0xe8
Caller[f02aafb8]: __start_notes+0x6c8/0x708
Caller[f00141cc]: kernel_thread+0x3c/0x50
Caller[f01f3564]: rest_init+0x18/0x5c
Caller[f02ab2f8]: sun4m_init+0x1ac/0x328
Caller[f02aa790]: __bzero_end+0x1ec8/0x2028
Caller[0030509c]: 0x3050a4
Instruction DUMP: 80a0c002  22800008  c2010000 <c200e008> 80a04019 
3a800004  c2010000  10bffff8  88100003
Kernel panic - not syncing: Attempted to kill init!

Looks like the sun4c memory management system has got messed up again!!

Regards
 	Mark Fortescue.
--1750305931-1952666620-1185675459=:28781
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fix-console.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0707290317370.28781@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: attachment; filename="fix-console.patch"

LS0tIGxpbnV4LXRlc3QvYXJjaC9zcGFyYy9rZXJuZWwvcHJvbS5jfgkyMDA3
LTA3LTI4IDIxOjAyOjMxLjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LXRl
c3QvYXJjaC9zcGFyYy9rZXJuZWwvcHJvbS5jCTIwMDctMDctMjkgMDI6Mzg6
NTQuMDAwMDAwMDAwICswMTAwDQpAQCAtNDYwLDcgKzQ2MCw3IEBADQogCQlz
dHJjcHkob2ZfY29uc29sZV9wYXRoLCBkcC0+ZnVsbF9uYW1lKTsNCiAJCWlm
ICghc3RyY21wKHR5cGUsICJzZXJpYWwiKSkgew0KIAkJCXN0cmNhdChvZl9j
b25zb2xlX3BhdGgsDQotCQkJICAgICAgIChza2lwID8gIjpiIiA6ICI6YSIp
KTsNCisJCQkgICAgICAgKHNraXAgPyAiOmEiIDogIjpiIikpOw0KIAkJfQ0K
IAkJYnJlYWs7DQogDQo=

--1750305931-1952666620-1185675459=:28781--
