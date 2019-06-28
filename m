From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 12:54:01 +0000
Subject: Re: [PATCH 28/39] docs: admin-guide: add a series of orphaned documents
Message-Id: <be37b10b-81e1-8258-e149-a27942e98173@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <CGME20190628123124epcas2p3edc3c3a64edf324948a9ec1f9e41b974@epcas2p3.samsung.com>
 <7ee0e33575633f689203f582259c2cbdce477176.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <7ee0e33575633f689203f582259c2cbdce477176.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rich Felker <dalias@libc.org>, Mike Snitzer <snitzer@redhat.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "Richard Russon (FlatCap)" <ldm@flatcap.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, dm-devel@redhat.com, linux-efi@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, linux-rtc@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@in>


On 6/28/19 2:30 PM, Mauro Carvalho Chehab wrote:
> There are lots of documents that belong to the admin-guide but
> are on random places (most under Documentation root dir).
> 
> Move them to the admin guide.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  Documentation/ABI/stable/sysfs-devices-node     |  2 +-
>  Documentation/ABI/testing/procfs-diskstats      |  2 +-
>  Documentation/ABI/testing/sysfs-block           |  2 +-
>  .../ABI/testing/sysfs-devices-system-cpu        |  4 ++--
>  .../{btmrvl.txt => admin-guide/btmrvl.rst}      |  0
>  .../clearing-warn-once.rst}                     |  0
>  .../{cpu-load.txt => admin-guide/cpu-load.rst}  |  0
>  .../cputopology.rst}                            |  0
>  .../admin-guide/device-mapper/statistics.rst    |  4 ++--
>  .../{efi-stub.txt => admin-guide/efi-stub.rst}  |  0
>  .../{highuid.txt => admin-guide/highuid.rst}    |  0
>  Documentation/admin-guide/hw-vuln/l1tf.rst      |  2 +-
>  .../hw_random.rst}                              |  0
>  Documentation/admin-guide/index.rst             | 17 +++++++++++++++++
>  .../{iostats.txt => admin-guide/iostats.rst}    |  0
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  .../kernel-per-CPU-kthreads.rst}                |  0
>  .../lcd-panel-cgram.rst                         |  2 --
>  Documentation/{ldm.txt => admin-guide/ldm.rst}  |  0
>  .../lockup-watchdogs.rst}                       |  0
>  .../mm/cma_debugfs.rst}                         |  2 --
>  Documentation/admin-guide/mm/index.rst          |  1 +
>  .../{numastat.txt => admin-guide/numastat.rst}  |  0
>  Documentation/{pnp.txt => admin-guide/pnp.rst}  |  0
>  Documentation/{rtc.txt => admin-guide/rtc.rst}  |  0
>  .../{svga.txt => admin-guide/svga.rst}          |  0
>  Documentation/admin-guide/sysctl/kernel.rst     |  2 +-
>  .../video-output.rst}                           |  0
>  Documentation/fb/vesafb.rst                     |  2 +-
>  Documentation/x86/topology.rst                  |  2 +-
>  MAINTAINERS                                     | 12 ++++++------
>  arch/arm/Kconfig                                |  2 +-
>  arch/parisc/Kconfig                             |  2 +-
>  arch/sh/Kconfig                                 |  2 +-
>  arch/sparc/Kconfig                              |  2 +-
>  arch/x86/Kconfig                                |  4 ++--
>  block/partitions/Kconfig                        |  2 +-
>  drivers/char/Kconfig                            |  4 ++--
>  drivers/char/hw_random/core.c                   |  2 +-
>  include/linux/hw_random.h                       |  2 +-
>  40 files changed, 47 insertions(+), 33 deletions(-)
>  rename Documentation/{btmrvl.txt => admin-guide/btmrvl.rst} (100%)
>  rename Documentation/{clearing-warn-once.txt => admin-guide/clearing-warn-once.rst} (100%)
>  rename Documentation/{cpu-load.txt => admin-guide/cpu-load.rst} (100%)
>  rename Documentation/{cputopology.txt => admin-guide/cputopology.rst} (100%)
>  rename Documentation/{efi-stub.txt => admin-guide/efi-stub.rst} (100%)
>  rename Documentation/{highuid.txt => admin-guide/highuid.rst} (100%)
>  rename Documentation/{hw_random.txt => admin-guide/hw_random.rst} (100%)
>  rename Documentation/{iostats.txt => admin-guide/iostats.rst} (100%)
>  rename Documentation/{kernel-per-CPU-kthreads.txt => admin-guide/kernel-per-CPU-kthreads.rst} (100%)
>  rename Documentation/{auxdisplay => admin-guide}/lcd-panel-cgram.rst (99%)
>  rename Documentation/{ldm.txt => admin-guide/ldm.rst} (100%)
>  rename Documentation/{lockup-watchdogs.txt => admin-guide/lockup-watchdogs.rst} (100%)
>  rename Documentation/{cma/debugfs.rst => admin-guide/mm/cma_debugfs.rst} (98%)
>  rename Documentation/{numastat.txt => admin-guide/numastat.rst} (100%)
>  rename Documentation/{pnp.txt => admin-guide/pnp.rst} (100%)
>  rename Documentation/{rtc.txt => admin-guide/rtc.rst} (100%)
>  rename Documentation/{svga.txt => admin-guide/svga.rst} (100%)
>  rename Documentation/{video-output.txt => admin-guide/video-output.rst} (100%)
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
