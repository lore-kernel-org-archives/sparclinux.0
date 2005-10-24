From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 24 Oct 2005 15:15:40 +0000
Subject: Re: SILO and load address
Message-Id: <20051024.081540.32770274.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <435CD27D.80109@itbs.cz>
In-Reply-To: <435CD27D.80109@itbs.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jakub Jermar <jermar@itbs.cz>
Date: Mon, 24 Oct 2005 14:24:29 +0200

> I am having troubles with SILO loading my ELF image 
> (non-linux kernel). The problem is that the kernel is not 
> loaded to the address wich is specified in the ELF, but to 
> some other address. Is there a workaround for that? Or do I 
> miss the point?

Silo loads your image into a fixed address, it ignores the
load sections of your ELF image.  You thus have to relocate
yourself to where you want to run, just like the Linux
kernel does on sparc.
