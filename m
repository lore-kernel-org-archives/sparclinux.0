From: Peter Hurley <peter@hurleysoftware.com>
Date: Sun, 01 Dec 2013 02:07:08 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <529A99CC.9000804@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/30/2013 08:31 PM, Meelis Roos wrote:
>> Does the RED state exception trigger if you manually break to the prom
>> command line and issue a boot command?
>
> It seems I can not break from running kernel to PROM by sending break
> from minicom. PROM itself reacts to my break (during memory test for
> example) so it's Linux not accepting the break. I seem to remember it
> having worked some time ago, although not when the kergel hung.

Argghh.

There were some changes to sunsab.c a couple of versions ago; maybe we
broke it.

Can you confirm BRKs are being received with
'sudo cat /proc/tty/driver/serial'
?
