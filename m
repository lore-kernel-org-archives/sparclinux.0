From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 27 Feb 2021 10:46:39 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <2e9d0fe6-43ed-17ed-5bc1-00dd57bc4856@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2/27/21 11:31 AM, Meelis Roos wrote:
> 26.02.21 23:26 Rob Gardner wrote:
> 
>> Here is a single patch that does everything, and is cleaned up and more concise. If this all works
>> then I can send it as an official patch (though with the printk removed of course.)
> 
> Hand-applied it (whitespace damage or did my Thunderbird expand the tabs?) and tested with the same
> 2 opcodes as before + random opcodes. Works stable, nothing particular in dmesg - only these but these
> are frequent in tty code on sparcs:
> 
> [   53.514956] CPU[0]: Cheetah+ D-cache parity error at TPC[000000000076888c]
> [   53.621019] TPC<n_tty_set_termios+0x2c/0x3c0>
> 
> So it seems good, thanks!

Great news. I'm glad this issue finally gets fixed!

Thanks to both you and Rob for your efforts, much appreciated!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
