From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 13 Oct 2017 15:34:57 +0000
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
Message-Id: <CAOAebxt6BMFs_vfobDhd=mP2hDiPQFVsenxyUdktm6bSmwfvVg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
 <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
In-Reply-To: <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Here is simplified qemu command:

qemu-system-aarch64 \
      -display none \
      -kernel ./arch/arm64/boot/Image  \
      -M virt -cpu cortex-a57 -s -S

In a separate terminal start arm64 cross debugger:

$ aarch64-unknown-linux-gnu-gdb ./vmlinux
...
Reading symbols from ./vmlinux...done.
(gdb) target remote :1234
Remote debugging using :1234
0x0000000040000000 in ?? ()
(gdb) c
Continuing.
^C
(gdb) lx-dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.0-rc4_pt_study-00136-gbed2c89768ba
(soleen@xakep) (gcc version 7.1.0 (crosstool-NG
crosstool-ng-1.23.0-90-g81327dd9)) #1 SMP PREEMPT Fri Oct 13 11:24:46
EDT 2017
... until the panic message is printed ...

Thank you,
Pavel
