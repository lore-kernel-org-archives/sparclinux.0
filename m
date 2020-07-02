From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 02 Jul 2020 19:58:40 +0000
Subject: Re: [PATCH] sparc: sparc64_defconfig: add necessary configs for qemu
Message-Id: <275363bb-2f36-f7f3-aa7e-4a2fc6901d63@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 02/07/2020 14:02, Corentin Labbe wrote:

> The sparc64 qemu machines uses pcnet32 network hardware by default, so for
> simple boot testing using qemu, having PCNET32 is useful.
> Same for its storage which is a PATA_CMD64.

Which version of QEMU are you using? qemu-system-sparc64 switched to using a hme NIC
by default in version 2.11 (see
https://wiki.qemu.org/Documentation/Platforms/SPARC#Changes_to_sun4u_machine_from_2.11_onwards)
which is well over 2 years ago...


ATB,

Mark.
