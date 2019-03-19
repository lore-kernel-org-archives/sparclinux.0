From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 19 Mar 2019 11:24:41 +0000
Subject: [sparc] git kernel 5.1.0-rc1 TPC in __do_proc_doulongvec_minmax
Message-Id: <CADxRZqxkxD_tkrDwBAOhWi-LuTi6S3n0PBPahADiiOv0HKKMkw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Got git kernel 5.1.0-rc1 TPC :

$ dmesg | grep -A2 -B2 -i TPC
[    8.408102] systemd[1]: Detected architecture sparc64.
[    8.456289] systemd[1]: Set hostname to <ttip>.
[    8.474786] Kernel unaligned access at TPC[46f1b0]
__do_proc_doulongvec_minmax+0x110/0x3a0
[    9.406489] random: lvmconfig: uninitialized urandom read (4 bytes read)
[   10.073671] systemd[1]: File
/lib/systemd/system/systemd-journald.service:12 configures an IP
firewall (IPAddressDeny=any), but the local system does not support
BPF/cgroup based firewalling.

$ uname -a
Linux ttip 5.1.0-rc1 #937 SMP Mon Mar 18 13:06:52 MSK 2019 sparc64 GNU/Linux


full dmesg and kernel config is at https://github.com/mator/sparc64-dmesg
