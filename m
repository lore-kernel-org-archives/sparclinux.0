From: LABBE Corentin <clabbe@baylibre.com>
Date: Fri, 03 Jul 2020 05:55:51 +0000
Subject: Re: [PATCH] sparc: sparc64_defconfig: add necessary configs for qemu
Message-Id: <20200703055551.GA14096@Red>
List-Id: <sparclinux.vger.kernel.org>
References: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
 <275363bb-2f36-f7f3-aa7e-4a2fc6901d63@ilande.co.uk>
In-Reply-To: <275363bb-2f36-f7f3-aa7e-4a2fc6901d63@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Jul 02, 2020 at 08:58:40PM +0100, Mark Cave-Ayland wrote:
> On 02/07/2020 14:02, Corentin Labbe wrote:
> 
> > The sparc64 qemu machines uses pcnet32 network hardware by default, so for
> > simple boot testing using qemu, having PCNET32 is useful.
> > Same for its storage which is a PATA_CMD64.
> 
> Which version of QEMU are you using? qemu-system-sparc64 switched to using a hme NIC
> by default in version 2.11 (see
> https://wiki.qemu.org/Documentation/Platforms/SPARC#Changes_to_sun4u_machine_from_2.11_onwards)
> which is well over 2 years ago...
> 

You are right, I verfied in the code and it is sunhme by default.
So I will verify it works and send a v2.
