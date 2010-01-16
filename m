From: David Miller <davem@davemloft.net>
Date: Sat, 16 Jan 2010 01:32:28 +0000
Subject: Re: Something's up with mondo
Message-Id: <20100115.173228.243551250.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.1001160159400.29759@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.1001160159400.29759@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Sat, 16 Jan 2010 02:05:54 +0100 (CET)

> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> Power down.
> CPU[13]: SUN4V mondo timeout, no forward  progress after 10001 retries.
> CPU[13]: CPU list [ 4 ]
> CPU[13]: SUN4V mondo timeout, no forward  progress after 10001 retries.
> CPU[13]: CPU list [ 4 ]
> [...]

It just means that we're trying to send inter-cpu interrupt messages
and the target cpus are not responding.

Some cpus dying in the firmware or somewhere in the kernel due
an unclean shutdown/poweroff would certainly cause this.
