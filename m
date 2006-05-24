From: David Miller <davem@davemloft.net>
Date: Wed, 24 May 2006 04:49:51 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <20060523.214951.48799095.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurijus@wooyd.org>
Date: Tue, 23 May 2006 21:33:25 -0700 (PDT)

> FWIW, I have just reproduced the problem on my Ultra5 running 2.6.17-rc4 
> by trying to install KDE and all dependencies :-(.

How exactly does dpkg access these files (particularly the 'status'
file)?  It is just normal reads and writes, or does it use mmap()?
