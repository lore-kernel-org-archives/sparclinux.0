From: David Miller <davem@davemloft.net>
Date: Thu, 23 Sep 2010 16:01:54 +0000
Subject: Re: Question about interrupt processing on Sparc64
Message-Id: <20100923.090154.232904733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
In-Reply-To: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex <alexvm12e@mail.ru>
Date: Thu, 23 Sep 2010 19:45:57 +0400

> 
> I'm sorry. There is head_64.o in /arch/sparc/kernel. I mean there aren't 
> ttable.o and sun4v_ivec.o files.

Why would there be?  The code from ttable.S and sun4v_ivec.S get
compiled into that head_64.o object file.
