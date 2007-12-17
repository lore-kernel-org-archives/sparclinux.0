From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Mon, 17 Dec 2007 23:53:03 +0000
Subject: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <47670BDF.80409@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-9160-4803@http.bugzilla.kernel.org/> <47112797.7060003@s5r6.in-berlin.de>
In-Reply-To: <47112797.7060003@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, linux1394-devel@lists.sourceforge.net

Stefan Richter wrote on 2007-10-13:
> bugme-daemon@bugzilla.kernel.org wrote:
>> http://bugzilla.kernel.org/show_bug.cgi?id=9160

It's a 100% reproducible oops on Sparc (with FireWire controller) for
2.6.23 and 2.6.24 kernels, but not 2.6.22.  The reporter confirmed that
the bug also happens
  - with plain 2.6.24-rc5,
  - with 2.6.23.y and the firewire subsystem fully reverted to that of
    2.6.22.

This has also been reported independently once before against
2.6.23-rc3, http://marc.info/?l=3Dlinux-sparc&m=118751438108687 in August.

>> Oct 13 20:26:04 succubus OOPS: Bogus kernel PC [0000000000000000] in fau=
lt handler
>> Oct 13 20:26:04 succubus OOPS: RPC [0000000010068cd0]
>> Oct 13 20:26:04 succubus RPC: <ar_context_add_page+0xd8/0x160 [firewire_=
ohci]>
>> Oct 13 20:26:04 succubus OOPS: Fault was to vaddr[1004e000]
>> Oct 13 20:26:04 succubus Call Trace:
>> Oct 13 20:26:04 succubus [00000000004076f4] sparc64_realfault_common+0x1=
8/0x20
>> Oct 13 20:26:04 succubus [0000000010068cd0] ar_context_add_page+0xd8/0x1=
60 [firewire_ohci]
>> Oct 13 20:26:04 succubus [0000000010068d90] ar_context_init+0x38/0x60 [f=
irewire_ohci]
>> Oct 13 20:26:04 succubus [000000001006ac50] pci_probe+0xf8/0x340 [firewi=
re_ohci]
>> Oct 13 20:26:04 succubus [00000000005299bc] pci_device_probe+0x64/0xa0
>> Oct 13 20:26:04 succubus [0000000000550a28] driver_probe_device+0x90/0x1=
c0
>> Oct 13 20:26:04 succubus [0000000000550bc0] __driver_attach+0x68/0x80
>> Oct 13 20:26:04 succubus [000000000054fe5c] bus_for_each_dev+0x44/0x80
>> Oct 13 20:26:04 succubus [0000000000550218] bus_add_driver+0x80/0x1c0
>> Oct 13 20:26:04 succubus [0000000000529b7c] __pci_register_driver+0x44/0=
xa0
>> Oct 13 20:26:04 succubus [000000000047d5cc] sys_init_module+0x134/0x1400
>> Oct 13 20:26:04 succubus [0000000000406094] linux_sparc_syscall32+0x3c/0=
x40
>> Oct 13 20:26:04 succubus [00000000000133d8] 0x133e0
>> Oct 13 20:26:04 succubus Unable to handle kernel NULL pointer dereference
>> Oct 13 20:26:04 succubus tsk->{mm,active_mm}->context =3D 00000000000001=
f9
>> Oct 13 20:26:04 succubus tsk->{mm,active_mm}->pgd =3D fffff8004f9f8000
[...]

The fault happens due to dma_sync_single_for_device() which
drivers/firewire/fw-ohci.c calls in ar_context_add_page() when still
being in its pci_probe method.  I suspect that --- at least on Sparc and
after 2.6.22 --- it is not possible anymore to use dma_sync_* before the
pci_device's or device's probe was finished.

Would that be a bug in the Sparc platform code?  Or a bug in driver core
code or in PCI code?  Or am I expected to refrain from dma_sync_* calls
until after the probe returned?

(Doing the latter might be tricky, but I suspect that the AR buffers in
fw-ohci would generally be better off using coherent allocations.  The
DMA mapping and syncing in this part of fw-ohci is currently slightly
messy.)

Thanks for any comments,
--=20
Stefan Richter
-=3D=3D=3D-=3D-=3D=3D =3D-- =3D--=3D-
http://arcgraph.de/sr/
