From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Mon, 03 Oct 2005 12:50:38 +0000
Subject: cs4231 on sbus (ultra 2)
Message-Id: <4341291E.5060001@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I am using 2.6.14-rc2-git4, which includes the patch for cs4231
on sbus sent in by Christopher Zimmermann. It does not work
properly on my machine, there is a lot of noise in the playback.
As I am no kernel programmer, I need some help in sorting out
the problems.
After looking at the code I have a few questions:

1) After playing some sound, the DMA-controller is not reset,
    so that playing the next sound will start with the rest of the
    recent sound. Is there a way to reset a single DMA channel?
2) Is it correct that not incrementing p_periods_sent when the
    first block of data is transfered will lead to playing the same
    block twice?
3) snd_cs4231_playback_pointer returns a value which is two
    period_bytes larger than the DMA-pointer. Shouldn't it return
    a value which reflects the state of the current DMA-process?
4) Other drivers use sbus_map_single or pci_map_single to get
    hold of DMA-buffers. This is not the case with this driver. Is
    it not needed here?

Any comments and suggestions are welcome.

Regards
             Georg Chini

