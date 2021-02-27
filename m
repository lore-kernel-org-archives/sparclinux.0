From: Meelis Roos <mroos@linux.ee>
Date: Sat, 27 Feb 2021 10:31:10 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <8a2e371d-a8d6-9520-5428-602b5361ea74@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

26.02.21 23:26 Rob Gardner wrote:

> Here is a single patch that does everything, and is cleaned up and more concise. If this all works then I can send it as an official patch (though with the printk removed of course.)

Hand-applied it (whitespace damage or did my Thunderbird expand the tabs?) and tested with the same 2 opcodes as before + random opcodes. Works stable, nothing particular in dmesg - only these but these are frequent in tty code on sparcs:

[   53.514956] CPU[0]: Cheetah+ D-cache parity error at TPC[000000000076888c]
[   53.621019] TPC<n_tty_set_termios+0x2c/0x3c0>

So it seems good, thanks!

-- 
Meelis Roos <mroos@linux.ee>
