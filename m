From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 01 Jan 2018 21:11:49 +0000
Subject: [sparc64] kernel unaligned access at TPC aa_dfa_unpack
Message-Id: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-security-module@vger.kernel.org

Hello!

Using latest git kernel (4.15.0-rc6) , getting the following messages
on LDOM/kernel boot:

[    7.693653] Kernel unaligned access at TPC[7496d8] aa_dfa_unpack+0x38/0x580
[    7.693735] Kernel unaligned access at TPC[7496f8] aa_dfa_unpack+0x58/0x580
[    7.693782] Kernel unaligned access at TPC[749708] aa_dfa_unpack+0x68/0x580
[    7.693829] Kernel unaligned access at TPC[74973c] aa_dfa_unpack+0x9c/0x580
[    7.693875] Kernel unaligned access at TPC[749758] aa_dfa_unpack+0xb8/0x580
[    7.697135] audit: type00 audit(1514840016.480:2):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/sbin/tcpdump" pidP7 comm="apparmor_parser"


Can someone please look, what could cause unaligned access at this
aa_dfa_unpack function/structure ?


kernel config for apparmor is the following:

$ grep APPARMOR /boot/config-4.15.0-rc6
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_DEBUG=y
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=y
# CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y


Thanks!
