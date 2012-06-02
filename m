From: Marcel van Nies <morcles@gmail.com>
Date: Sat, 02 Jun 2012 18:12:26 +0000
Subject: Re: sparc32: some more testing
Message-Id: <CACEWtaBCzwVzOb3E4i5jnSTUpvz_CQLygmr4gO+0qBD6nPcyOw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I tried to revert commit 4d14a459857bd151ecbd14bcd37b4628da00792b.
We had

UP kernel:
SS20 with SuperSPARC-II 75MHz : boots, but various binaries either
BUG, give "Illegal instruction", receive signal 4, ...
SS20 with HyperSPARC 125MHz : boots, INIT segfaults

SMP kernel:
SS20 with dual SuperSPARC-II 75MHz :  boots, loading INIT is
slooooooow ... takes like 1 minute or so ... finally system freezes
SS20 with quad HyperSPARC 125MHz : boots, INIT segfaults

Now, after reverted commit 4d14a459857bd151ecbd14bcd37b4628da00792b we have

UP dirty kernel:
SS20 with SuperSPARC-II 75MHz : boots, but various binaries either
BUG, give "Illegal instruction", receive signal 4, ...
SS20 with HyperSPARC 125MHz : works

SMP dirty kernel:
SS20 with SuperSPARC-II 75MHz : boots, but various binaries either
BUG, give "Illegal instruction", receive signal 4, ...
SS20 with quad HyperSPARC 125MHz :  boots, but system freezes shortly after INIT

M
